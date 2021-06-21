//
//  RxSwift.swift
//  ToDoRxSwift
//
//  Created by Doron Feldman on 13/11/2020.
//

import Foundation
import RxSwift
import RxRelay

enum DemoError: Error {
    case someError
    case cantParseJSON
    case failedCaching
}

let observable = Observable<Int>.create { observer in
    print("subscribeOn thread: \(Thread.current)")
    
    // Sending the next value down the pipe
    observer.on(.next(1))
    // this is how we throw an error
    observer.on(.error(DemoError.someError))
    // this is how we mark completed
    observer.on(.completed)
    
    return Disposables.create {
        print("Cancel stuff")
    }
}

let subscription = observable
    .subscribe { (event: Event<Int>) in
        switch event {
        case .next(let element):
            print(element)
        case .error(let error):
            print(error)
        case .completed:
            print("completed")
        }
}


// We must dispose of a subscription in order to avoid memory leaks
subscription.dispose()

// A dispose bag is a convinience to behave more like ARC
let disposeBag = DisposeBag()
let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)

observable
    .subscribeOn(scheduler)
    .observeOn(MainScheduler.instance)
    .subscribe(
        onNext: { element in
            print("observeOn thread: \(Thread.current)")
            print(element)
        },
        onError: { error in
            print(error)
        },
        onCompleted: {
            print("completed")
        }
    )
    .disposed(by: disposeBag)
