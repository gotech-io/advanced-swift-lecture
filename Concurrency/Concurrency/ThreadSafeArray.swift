//
//  ThreadSafeArray.swift
//  Concurrency
//
//  Created by Doron Feldman on 14/10/2020.
//

import Foundation

class ThreadSafeArray<T> {
    private let queue = DispatchQueue(label: "ThreadSafeArray", attributes: [.concurrent])
    private var array: [T]
    
    init(initialValue: [T]? = nil) {
        if let val = initialValue {
            array = val
        } else {
            array = []
        }
    }
    
    func clear() {
        queue.sync {
            self.array = []
        }
    }
    
    func append(_ item: T) {
        queue.sync(flags: .barrier) {
            self.array.append(item)
        }
    }
    
    var count: Int {
        get {
            queue.sync {
                return array.count
            }
        }
    }
    
    subscript(index: Int) -> T {
        queue.sync {
            return array[index]
        }
    }
}
