//
//  RxSwift.swift
//  ToDoRxSwift
//
//  Created by Doron Feldman on 13/11/2020.
//

import Foundation
import RxSwift
import RxRelay

let disposeBag = DisposeBag()
let behaviorRelay = BehaviorRelay<String>(value: "Hello") // Notice the value here?

behaviorRelay
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

// Notice that it's only accept, there is no onCompleted or onError
behaviorRelay.accept("Hello 2")
