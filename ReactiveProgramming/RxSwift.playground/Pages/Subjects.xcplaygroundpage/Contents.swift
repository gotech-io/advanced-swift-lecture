//
//  RxSwift.swift
//  ToDoRxSwift
//
//  Created by Doron Feldman on 13/11/2020.
//

import Foundation
import RxSwift

enum DemoError: Error {
    case someError
    case cantParseJSON
    case failedCaching
}

let disposeBag = DisposeBag()

let asyncSubject = AsyncSubject<String>() // No value here

asyncSubject.onNext("Pink 1")
asyncSubject.onNext("Pink 2")
asyncSubject.onNext("Pink 3")
asyncSubject.onNext("Pink 4")
asyncSubject.onNext("Pink 5")
asyncSubject.onCompleted()
asyncSubject.onError(DemoError.someError)

asyncSubject
    .subscribe(
        onNext: { element in
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

let behaviorSubject = BehaviorSubject<String>(value: "Hello") // Notice the value here?
behaviorSubject
    .subscribe(
        onNext: { element in
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

// Can just get the current value of the subject, notice that we need to "try",
// if last emmited event was an error, this will throw
let currValue = try? behaviorSubject.value()
behaviorSubject.onNext("Hello 2")
behaviorSubject.onCompleted()
behaviorSubject.onError(DemoError.someError)


let publishSubject = PublishSubject<String>() // No value here
publishSubject.onNext("Hello")
publishSubject.onCompleted()
publishSubject.onError(DemoError.someError)

let replaySubject = ReplaySubject<String>.create(bufferSize: 3)
replaySubject.onNext("Hello")
replaySubject.onCompleted()
replaySubject.onError(DemoError.someError)
