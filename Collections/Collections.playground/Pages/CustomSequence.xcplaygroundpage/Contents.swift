
//creating infinite sequence generator by implementing Sequence and IteratorProtocol
struct DoubleGenerator: Sequence, IteratorProtocol {
    var current = 1

    mutating func next() -> Int? {
        defer {
            current *= 2
        }

        return current
    }
}

var i = 0
//Iterating over our custom generator
let numbers = DoubleGenerator()
for number in numbers {
    i += 1
    if i == 10 { break }

    print(number)
}


//lazy sequence
let numbersArray = Array(1...100000)

//here we perfrom an action on numbersArray, but this action is not performed right away/
//it is performed once we accessing specific item in lazyDoubled
let lazyDoubled = numbersArray.lazy.map { $0 * 2 }
