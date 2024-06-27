//// MARK: Product
//struct House {
//    let rooms: Int
//    let doors: Int
//    let windowns: Int
//}
//
//extension House: CustomStringConvertible {
//    public var description: String {
//        return "\(rooms) Rooms, \(doors) Doors and \(windowns) Windons"
//    }
//}
//
//// MARK: Builder
//class HouseBuilder {
//    var rooms: Int = 0
//    var doors: Int = 0
//    var windowns: Int = 0
//    
//    func addRooms(numberOfRooms: Int) {
//        self.rooms = numberOfRooms
//    }
//    
//    func addDoors(numberOfDoors: Int) {
//        self.doors = numberOfDoors
//    }
//    
//    func addWindowns(numberOfWindowns: Int) {
//        self.windowns = numberOfWindowns
//    }
//    
//    func build() -> House {
//        return House(rooms: rooms, doors: doors, windowns: windowns)
//    }
//}
//
//// MARK: Director
//public class Person {
//    func buildHouse() throws -> House {
//        let builder = HouseBuilder()
//        builder.addRooms(numberOfRooms: 6)
//        builder.addDoors(numberOfDoors: 2)
//        builder.addWindowns(numberOfWindowns: 10)
//        return builder.build()
//    }
//}
//
//let person = Person()
//if let house = try? person.buildHouse() {
//    print("The House consist Of" + house.description)
//}
import XCTest

/// The Builder interface specifies methods for creating the different parts of
/// the Product objects.
protocol Builder {

    func producePartA()
    func producePartB()
    func producePartC()
}

/// The Concrete Builder classes follow the Builder interface and provide
/// specific implementations of the building steps. Your program may have
/// several variations of Builders, implemented differently.
