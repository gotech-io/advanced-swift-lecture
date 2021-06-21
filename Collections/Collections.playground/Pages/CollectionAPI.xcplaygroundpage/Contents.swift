import UIKit

//filter
let numbers = Array(1...10)

//will print only even numbers
print(numbers.filter{ $0%2 == 0 })

//first

//first even number
print(numbers.first{ $0%2 == 0})

//sorted
struct Student {
    let name: String
    let grade: Int
}
let students = [Student(name: "giora", grade: 50), Student(name: "doron", grade: 100), Student(name: "lidor", grade: 80), Student(name: "yaniv", grade: 80)]
print(students.sorted{ $0.grade < $1.grade })


//map
print(students.map{ $0.grade + 10})

//reduce
//sums up objcets by the provided closure to single value
print(students.reduce(0){ $0 + $1.grade})



//compactMap
//removes null objects results
let possibleNumbers = ["1", "2", "three", "///4///", "5"]
print( possibleNumbers.map { Int($0)})
print( possibleNumbers.compactMap{ Int($0)})

//flatMap

func hashtags(in string: String) -> [String] {
    let words = string.components(
        separatedBy: .whitespacesAndNewlines
    )

    let tags = words.filter { $0.starts(with: "#") }
    
    // Using 'map' we can convert a sequence of values into
    // a new array of values, using a closure as a transform:
    return tags.map { $0.lowercased() }
}


let strings = [
    "I'm excited about #SwiftUI",
    "#Combine looks cool too",
    "This year's #WWDC was amazing"
]

//In this case function hashtags return array of strings
//so map returns array of arrays, we don't want that
print(strings.map { hashtags(in: $0) })

//flat map reduces the two dementionional array to single array
print(strings.flatMap(hashtags))

//group by
//in case we want to group by results by custom filter, we can use dictionaty group by
let groupByGrades = Dictionary(grouping: students, by: { $0.grade})
print(groupByGrades)

//lazy
//we can use it if we don't want collection operation to be performed right away on all array members
//in this case the operation will performed only when we access the of a specfic item in the collection
let flatStrings = strings.lazy.flatMap{ hashtags(in:$0)}


