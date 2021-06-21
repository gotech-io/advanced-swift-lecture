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

let disposeBag = DisposeBag()

let single = Single<[String: Any]>.create { single in
    let task = URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/albums")!) { data, _, error in
        if let error = error {
            single(.error(error))
            return
        }

        guard let data = data,
              let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
              let result = json as? [String: Any] else {
            single(.error(DemoError.cantParseJSON))
            return
        }
        single(.success(result))
    }

    task.resume()

    return Disposables.create { task.cancel() }
}

single.subscribe { event in
    switch event {
        case .success(let json):
            print("JSON: ", json)
        case .error(let error):
            print("Error: ", error)
    }
}
.disposed(by: disposeBag)


let completable = Completable.create { completable in
    // Do some caching logic
    let success = true

    guard success else {
        completable(.error(DemoError.failedCaching))
        return Disposables.create {}
    }

    completable(.completed)
    return Disposables.create {}
}

completable.subscribe(
    onCompleted: {
        print("Completed with no error")
    },
    onError: { error in
        print("Completed with an error: \(error.localizedDescription)")
    })
    .disposed(by: disposeBag)



let maybe = Maybe<String>.create { maybe in
    maybe(.success("RxSwift"))

    maybe(.completed)

    maybe(.error(DemoError.someError))

    return Disposables.create {}
}

maybe.subscribe { maybe in
    switch maybe {
        case .success(let element):
            print("Completed with element \(element)")
        case .completed:
            print("Completed with no element")
        case .error(let error):
            print("Completed with an error \(error.localizedDescription)")
    }
}
.disposed(by: disposeBag)

