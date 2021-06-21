//1. Properties
enum Device {
    case iPad
    case iPhone
    
    var year: Int {
        switch self {
        case .iPhone:
            return 2007
        case .iPad:
            return 2010
        }
    }
}

let device = Device.iPhone
print(device.year)



//2. Methods
enum Device1 {
    case iPad
    case iPhone
    
    func introduced() -> String {
        switch self {
        case .iPhone:
            return "\(self) was introduced 2007"
        case .iPad:
            return "\(self) was introduced 2010"
        }
    }
}

//3. Static Method
enum Device2 {
    case iPhone
    case iPad
    
    static func getDevice(name: String) -> Device? {
        switch name {
        case "iPhone":
            return .iPhone
        case "iPad":
            return .iPad
        default:
            return nil
        }
    }
}

if let device2 = Device2.getDevice(name: "iPhone") {
    print(device2)
}

let device1 = Device1.iPhone
print (device1.introduced())



//4. Mutating Method
enum TriStateSwitch {
    case off
    case low
    case high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.off
ovenLight.next()
ovenLight.next()
ovenLight.next()


//5. Custom Init
enum IntCategory {
    case small
    case medium
    case big
    case weird
    
    init(number: Int) {
        switch number {
        case 0..<1000 :
            self = .small
        case 1000..<100000:
            self = .medium
        case 100000..<1000000:
            self = .big
        default:
            self = .weird
        }
    }
}

let intCategory = IntCategory(number: 34645)
print(intCategory)



//6. Protocol Oriented Enum
//6.1 Create Protocol
protocol LifeSpan {
    var numberOfHearts: Int { get }
    mutating func getAttacked() // heart -1
    mutating func increaseHeart() // heart +1
}

//6.2 Create Enum
enum Player: LifeSpan {
    case dead
    case alive(currentHeart: Int)
    
    var numberOfHearts: Int {
        switch self {
        case .dead: return 0
        case let .alive(numberOfHearts): return numberOfHearts
        }
    }
    
    mutating func increaseHeart() {
        switch self {
        case .dead:
            self = .alive(currentHeart: 1)
        case let .alive(numberOfHearts):
            self = .alive(currentHeart: numberOfHearts + 1)
        }
    }
    
    mutating func getAttacked() {
        switch self {
        case .alive(let numberOfHearts):
            if numberOfHearts == 1 {
                self = .dead
            } else {
                self = .alive(currentHeart: numberOfHearts - 1)
            }
        case .dead:
            break
        }
    }
}

//6.3 Play Game
var player = Player.dead

player.increaseHeart()
print(player.numberOfHearts)

player.increaseHeart()
print(player.numberOfHearts)

player.getAttacked()
print(player.numberOfHearts)

player.getAttacked()
print(player.numberOfHearts)



//7. Generic Enums
enum Information<T1, T2> {
    case name(T1)
    case website(T1)
    case age(T2)
}


// let info = Information.name("Bob") // Error- Generic parameter 'T2' could not be inferred

let info = Information<String, Int>.age(20)
print(info)


//8. Extensions
enum Entities {
    case soldier(x: Int, y: Int)
    case tank(x: Int, y: Int)
    case player(x: Int, y: Int)
}

extension Entities {
    mutating func attack() {}
    mutating func move(distance: Float) {}
}

extension Entities: CustomStringConvertible {
    var description: String {
        switch self {
        case let .soldier(x, y): return "Soldier position is (\(x), \(y))"
        case let .tank(x, y): return "Tank position is (\(x), \(y))"
        case let .player(x, y): return "Player position is (\(x), \(y))"
        }
    }
}
print( Entities.soldier(x: 6, y: 3))
print(String(describing: Entities.soldier(x: 6, y: 3)))
