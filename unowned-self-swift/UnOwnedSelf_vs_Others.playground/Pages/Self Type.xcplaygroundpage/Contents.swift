//: [Previous](@previous)
/*:
 ## Self Type
 `Self` refers to the type itself, not a specific instance - and unlike hardcoding a class name, it resolves to whichever concrete type is actually calling it. See `HTMLElement.makeDefault()` vs `ParagraphElement.makeDefault()` below.
 */

import XCTest

class HTMLElement {
    static let defaultName = "div"
    static let defaultContent = "Default content"

    let name: String
    let text: String?

    required init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    // `Self` here means "whatever type this method is actually called on" -
    // not hardcoded to HTMLElement. This only matters because HTMLElement
    // is subclassable (not `final`) - see ParagraphElement below.
    static func makeDefault() -> Self {
        Self(name: Self.defaultName, text: Self.defaultContent)
    }
}

class ParagraphElement: HTMLElement {}

class HTMLElementTests: XCTestCase {
    func testMakeDefaultReturnsCallingType() {
        let base = HTMLElement.makeDefault()
        let paragraph = ParagraphElement.makeDefault()

        XCTAssertTrue(type(of: base) == HTMLElement.self)
        XCTAssertTrue(type(of: paragraph) == ParagraphElement.self)
    }
}

demo(
    "Self - Covariant Return Type",
    expecting: "Self resolves to whichever type is actually calling it"
) {
    HTMLElementTests.defaultTestSuite.run()
}

//: [Next](@next)
