//: [Previous](@previous)

import XCTest

final class Person: Sendable {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("✅ \(name) is being deinitialized") }
}

final class Apartment: Sendable {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("✅ Apartment \(unit) is being deinitialized") }
}

class PersonTests: XCTestCase {
    
    // This test fails
    func testPersonInstanceNotGettingDeallocatedSuccessfullyWithInitializingPersonWithApartmentAndApartmentWithTenant() {
        let unit4A = Apartment(unit: "4A")
        let person = Person(name: "John Appleseed")
        
        person.apartment = unit4A
        unit4A.tenant = person
        
        trackForMemoryLeaks(person)
    }
}

PersonTests.defaultTestSuite.run()

//: [Next](@next)
