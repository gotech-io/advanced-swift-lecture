import UIKit


//ranges

let names = ["Doron", "Giora", "GoTech"]

//closed range
//A closed range operator going from a...b defines a range that includes both a and b in which a must not be greater than b.
for index in 0...2 {
    print("Name \(index) is \(names[index])")
}

//A half-open range defines a range going from a to b but does not include b
print(names[0..<names.count])

//A one-sided range operator only defines one side of the bounds, for example, a... or ...b
for index in 0... {
    if index == names.count {
        break
    }
    print("Name \(index) is \(names[index])")
}


//Slicing

var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(numbers[0...5])
print(numbers[..<5])
print(numbers[1...])
print(numbers[...4])

