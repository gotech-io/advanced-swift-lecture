import Foundation

extension String: Error {} // Enables you to throw a string, good for quick examples

func iThrow(_ shouldThrow: Bool) throws {
    defer {
        print("1")
    }
    defer {
        print(two)
    }
    
    let two = "2"
    if shouldThrow {
        print("goodbye!")
        throw "Boom"
    }
    
    print("hello!")
    
    defer {
        print("3")
    }
}

try? iThrow(false)
try? iThrow(true)
