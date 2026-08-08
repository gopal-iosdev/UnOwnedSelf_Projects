/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 ## Running XCTest
 
 A `.playground` has no test target or scheme, so there's no `Product > Test` (⌘U)
 command and no green checkmarks in the gutter - `XCTestCase` still imports and
 compiles fine, but nothing triggers it automatically.

 Calling `PersonTests.defaultTestSuite.run()` manually is what makes it work: it
 synchronously runs every `test*` method on the class and reports pass/fail
 through `XCTAssert` calls, same as a normal test target would.

 The output only shows up as console logging in the debug area
 (`View > Debug Area > Activate Console`) - unlike the other pages there's no `setLiveView`
 here, since a test run isn't a `View` to render.

 To run just one test instead of the whole suite, construct the case directly
 with `init(selector:)` and call `.run()` on that single instance - see the
 commented-out lines below `PersonTests.defaultTestSuite.run()`.
 
 > **Note:** `sut` means "system under test" - a common testing convention
 > for the object being tested.
 */

import XCTest

struct Person {
    let name: String
    var occupation: String?
    
    init(name: String, occupation: String? = nil) {
        self.name = name
        self.occupation = occupation
    }
}

class PersonTests: XCTestCase {
    func testPersonInitializedWithGivenParams() {
        let name = "John AppleSeed"
        let occupation = "Designer"
        let sut = Person(name: name, occupation: occupation)
        
        XCTAssertEqual(sut.name, name)
        XCTAssertEqual(sut.occupation, occupation)
    }
    
    func testPersonInitializedWithOnlyName() {
        let name = "Steve"
        let sut = Person(name: name)
        
        XCTAssertEqual(sut.name, name)
        XCTAssertNil(sut.occupation)
    }
}

demo(
    "Running a single test in isolation",
    expecting: "only testPersonInitializedWithOnlyName to run, and to pass"
) {
    PersonTests(selector: #selector(PersonTests.testPersonInitializedWithOnlyName)).run()
}

demo(
    "Running the whole test suite",
    expecting: "both Person tests to run, and to pass"
) {
    PersonTests.defaultTestSuite.run()
}

