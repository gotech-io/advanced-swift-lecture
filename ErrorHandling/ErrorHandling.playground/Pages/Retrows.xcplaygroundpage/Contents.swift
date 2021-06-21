import Foundation

extension String: Error {} // Enables you to throw a string, good for quick examples

func logExecutionTime(block: () throws -> Void) rethrows {
    let start = DispatchTime.now()
    try block()
    let end = DispatchTime.now()
    print("Execution Time: \( end.uptimeNanoseconds - start.uptimeNanoseconds ) nanoseconds")
}

do {
    try logExecutionTime {
        throw "Boom"
    }
} catch {
    print(error)
}

do {
    try logExecutionTime {
        print("Boom")
    }
} catch {
    print(error)
}

