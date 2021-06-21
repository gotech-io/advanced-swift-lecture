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

let result = try? parseInt2("#@!")
if let aResult = result {
    print("result is \(aResult)")
}

func iDoNotCatch() {
    let result2 = try! parseInt2("#@!")
    print("result2 is \(result2)")
}

