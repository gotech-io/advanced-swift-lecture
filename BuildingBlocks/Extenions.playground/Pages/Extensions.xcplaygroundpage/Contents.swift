import UIKit


extension String {
    var lastLetter : String {
        guard let lastChar = self.last else {
            return ""
        }
        return String(lastChar)
    }


    func matchesRegex(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}


// seperate public api and private api
struct TodoItemViewModel {

    func func1() {
        
    }
    
    func func2() {
        
    }
}

private extension TodoItemViewModel {
    
    func func3() {
        
    }
}

protocol A {
    func foo1()
}

protocol B {
    func foo2()
}

//seperate protocol Protocol Conformance
extension TodoItemViewModel: A {
    
    func foo1() {
        
    }
}

extension TodoItemViewModel: B {
    
    func foo2() {
    
    }
}


//protocol extension
protocol Edible {
    func eat()
}

extension Edible
{
    func eat() {
        print("Eating the thing...")
    }
}

class Fish: Edible
{
    func eat() {
        print("**CHOMP** **CRUNCH** Eating the fish...")
    }
}

class Apple: Edible {
}

let apple = Apple()
apple.eat()

// Namespaced Constants and Nested Types
//You can’t add properties to an extension, but you can add static constants and subtypes to extensions. And that lets you do some Swift magic!
extension Notification.Name {
    static let statusUpdated = Notification.Name("status_updated")
}

NotificationCenter.default.post(name: .statusUpdated, object: nil)

