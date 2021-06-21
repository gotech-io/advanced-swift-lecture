import Foundation

enum IntParsingError: Error {
    case invalidInput(value: String)
    case emptyInput
}

func parseInt2(_ value: String) throws -> Int {
    guard !value.isEmpty else {
        throw IntParsingError.emptyInput
    }
    
    let parsedInt = Int(value)
    guard let _ = parsedInt else {
        throw IntParsingError.invalidInput(value: value)
    }
    
    return parsedInt!
}

do {
    try parseInt2("#@!")
} catch IntParsingError.invalidInput(let value) where value.count > 10  {
    print("Invalid input \(value) bigger than 10")
} catch IntParsingError.invalidInput(let value) {
    print("Invalid input \(value)")
} catch IntParsingError.emptyInput {
    print("Empty input")
} catch {
    print("Some error \(error)")
    // This kills the app and cannot be caught
    fatalError()
}

// it is also possible to declare a struct or a class to
enum StructErrorKind {
    case a
    case b
}

struct StructError: Error {
    let line: Int
    let column: Int
    let kind: StructErrorKind
}

do {
    throw StructError(line: 1, column: 2, kind: StructErrorKind.a)
} catch let e as StructError {
    print("This is a struct error: \(String(reflecting: e.kind)) \(e.line) \(e.kind)")
}
