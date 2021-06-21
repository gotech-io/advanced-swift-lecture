import Foundation

extension String: Error {} // Enables you to throw a string, good for quick examples

func parseInt(_ value: String) throws -> Int {
    let parsedInt = Int(value)
    guard let _ = parsedInt else {
        throw "\(value) cannot be parsed into an int"
    }
    return parsedInt!
}

do {
    try parseInt("#@!")
} catch {
    // Notice that you get the an implicit "error"
    print(error)
}
