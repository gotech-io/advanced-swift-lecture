import UIKit


class Pilot {
    let name: String
    let rocketName : String
    
    init(name: String , rocketName: String) {
        self.name = name
        self.rocketName = rocketName
    }
    
    func startFlight() {
        print("Look at me! i'm flying \(rocketName) rocket")
    }
}

class Rocket {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}


// This will fail baecuse we need to initialize Falcon9 property first according to first pahse of initialization
//class Falcon9_1: Rocket {
//    let pilot: Pilot
//
//    init() {
//        // Flipping the order will not help us solve the error
//        super.init(name: "Falcon9")
//        pilot = Pilot(name: "Major Tom", rocketName: self.name)
//    }
//}


// There are number of solution for problem

// Make Property implicitely unwrapped
// The problem here we forget to call assignPilot and trying to launch the rocket will crash
class Falcon9_3: Rocket {
    var pilot: Pilot!

    init() {
        super.init(name: "Falcon9")
    }

    func assignPilot() {
        pilot = Pilot(name: "Major Tom", rocketName: self.name)
    }

    func launch() {
        pilot.startFlight()
    }
}


// Make Property optional
// The problem here we will need to check for optional and not forget to call function assignPilot ,but solution is better, compiler error instead of crash
class Falcon9_4: Rocket {
    var pilot: Pilot?
    
    init() {
        super.init(name: "Falcon9")
    }
    
    func assignPilot() {
        pilot = Pilot(name: "Major Tom", rocketName: self.name)
    }
    
    func launch() {
        pilot?.startFlight()
    }
}


// Make property lazy
// In this case pilot will be initialized lazy, not optional. we don't have a problem forgetting
// assignPilot function. The only problem that it is now var instead let
class Falcon9_5: Rocket {
    lazy var pilot: Pilot = {
        return Pilot(name: "Major Tom", rocketName: self.name)
    }()
    
    init() {
        super.init(name: "Falcon9")
    }

    func launch() {
        pilot.startFlight()
    }
}



