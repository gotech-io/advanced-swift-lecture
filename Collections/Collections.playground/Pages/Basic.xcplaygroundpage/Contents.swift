import UIKit


// array
//diffrence initializations

let first = [1,2,3]
let second: [Int] = [1,2,3]
let third: Array<Int> = [1,2,3]

//immutable array
let immutableArray = [1,2,3]

//mutable array
var mutableArray = [1,2,3]
mutableArray.append(1)


//sets
var letters1 = Set<Character>()

letters1.insert("a")
print(letters1)

letters1.insert("b")
print(letters1)

letters1.insert("a")
print(letters1)

var letters2 = Set<Character>()
letters2.insert("b")


print(letters2.intersection(letters1))
print(letters2.union(letters1))

//Dictionary

//diffrent initializations

let firstDictionary = ["key": "value"]

let secondDictionary: [String: String] = ["key": "value"]

let thirdDictionary: Dictionary<String, String> = ["key": "value"]



