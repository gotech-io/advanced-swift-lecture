//
//  RxSwift.swift
//  ToDoRxSwift
//
//  Created by Doron Feldman on 13/11/2020.
//

import Foundation
import RxSwift
import RxRelay

let shareObservable = Observable<String>.create { observer in
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        print("Our fake api request")
        observer.onNext("I am API result!")
        observer.onCompleted()
    }
    return Disposables.create()
}
// .share(replay: 1, scope: .whileConnected) // This is where the magic happens

let capitalizedResult = shareObservable.map { $0.uppercased() }
let lowerCasedResult = shareObservable.map { $0.lowercased() }

// Subscribe for the first time
capitalizedResult.subscribe()
lowerCasedResult.subscribe()

// Subscribe for the second time
capitalizedResult.subscribe()
lowerCasedResult.subscribe()
