import UIKit

//class with 2 immutable properties
class Person {
    let firstname: String
    let lastname: String
    
    init(firstname: String, lastname: String) {
        self.firstname = firstname
        self.lastname = lastname
    }
}


//class with 3 immutable properties
class Person1 {
  let firstname: String
  let lastname: String
  let age: Int
  
  init(firstname: String, lastname: String, age: Int) {
    self.firstname = firstname
    self.lastname = lastname
    self.age = age
  }
}

//if we want to change property
//this way way we can keepp all properties immutable
extension Person1 {
  func age(age: Int) -> Person1 {
    return Person1(firstname: firstname, lastname: lastname, age: age)
  }
}

var person1 = Person1(firstname: "Doron", lastname: "Feldman", age: 33)
person1 = person1.age(age: 3)

//best way , use structs
struct Person3 {
    let firstname: String
    let lastname: String
    let age: Int
}

extension Person3 {
    func age(age: Int) -> Person3 {
        return Person3(firstname: firstname, lastname: lastname, age: age)
    }
}
