//: [Previous](@previous)

import XCTest

final class HTMLElement: @unchecked Sendable {
    let name: String
    let text: String?
    
    // () -> String, or “a function that takes no parameters, and returns a String value”.
    lazy var asHTML: () -> String = { [weak self] in
        if let self,
           let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(String(describing: self?.name)) />"
        }
    }
    
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
}

class HTMLElementTests: XCTestCase {
    func testSUTSuccessfullyDeInitializedAfterUse() {
        // `sut` here means system under test and `HTMLElement` is our SUT here.
        let sut = makeSUT(name: "p", text: "Hello, world")
        
        XCTAssertEqual(sut.asHTML(), "<p>Hello, world</p>")
    }
    
    private func makeSUT(
        name: String,
        text: String? = nil
    ) -> HTMLElement {
        let sut = HTMLElement(name: name, text: text)
        
        trackForMemoryLeaks(sut)
        
        return sut
    }
}

HTMLElementTests.defaultTestSuite.run()

//: [Next](@next)
