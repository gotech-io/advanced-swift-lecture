import UIKit

class A {
    var test: String = "Hello"
}

func address(o: UnsafeRawPointer) -> NSString {
    let addr = Int(bitPattern: o)
    return NSString(format: "%p", addr)
}

struct Point {
    var p: Int
    var a: A
}

// share a
let a = A()

var pointA = [Point(p: 25, a: a), Point(p: 20, a: a)]
//1
var pointB = pointA
//2

address(o: pointA)
address(o: pointB)

//if we add a reference type property inside a value type, those references won’t be copied like value types. Instead, the same reference would be used.
pointA[0].a.test = "Hello 2"

print("\(pointA[0].a.test), \((pointB[1].a.test))")

address(o: pointA)
address(o: pointB)

//if we change value type , a new array will be created , will point ot new address
pointB[0].p = 10

address(o: pointA)
address(o: pointB)


// you can use inout in order to mutate a value inside a function
func mutateArray(array: inout [String]) {
    array.append("World")
}

var arr = ["Hello"]
mutateArray(array: &arr)
