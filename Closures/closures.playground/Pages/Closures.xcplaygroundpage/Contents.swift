 import Foundation

// 1. Trailing closures

// when the last paramter is a closures,
// the call for the function looks like below, and it's called trailing closures
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel() {
    print("I'm driving in my car")
}

//2. Escaping closures

// In this first example the call the completion block is inside async block
// that means the function finished before this closure was used.
func doSomething1(completion: ((String) -> ())?) {
    DispatchQueue.global().async {
        completion?("hi")
    }
}
 
 // In this first example the call to the completion block is inside an async block
 // that means the function finished before this closure was used.
 func doSomething2(completion: @escaping (String) -> ()) {
     DispatchQueue.global().async {
         completion("hi")
     }
 }

var holder: ((String) -> ())?

// In the second example we use an external property so
// in this case the function also finished before the closure called
func doSomethingElse(completion:  @escaping (String) -> ()) {
    holder = completion
}

// 3. Automatic closures
// in this case we can pass fucntion without brackets
func getName() -> String{
    return "Doron"
}

func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: getName())

 
 // Demonstration of a Retain cycle
 protocol FooDelegate: AnyObject{
    func fun1()
 }
 
 // class a implements protocol FooDelegate
 class A: FooDelegate {
    func fun1() {
        
    }
    
    let b = B()
 }
 
 class B {
    //weak var delegate: FooDelegate?
    var delegate: FooDelegate?
 }
 
 let a = A()
 let b = B()
 
 // class b has a strong reference to class a, this creates a retain cycle
 b.delegate = a
 
// Retain cycle
class Example {

    private var counter = 0
    
    private var closure : (() -> ()) = { }
    
    init() {
        //closure has stong referbce to object
        closure = {
            //inside we create strong reference to self
            self.counter += 1
            print(self.counter)
        }
    }
    
    func foo() {
        closure()
    }
}

// using unowend
class Example1 {

    private var counter = 1
    
    private var closure : (() -> ()) = { }
    
    init() {
        closure = { [unowned self] in
            self.counter += 1
            print(self.counter)
        }
    }
    
    func foo() {
        closure()
    }
    
}


// using weak
class Example2 {

    private var counter = 1
    
    private var closure : (() -> ()) = { }
    
    init() {
        closure = { [weak self] in
            self?.counter += 1
            print(self?.counter ?? "")
        }
    }
    
    func foo() {
        closure()
    }
    
}
