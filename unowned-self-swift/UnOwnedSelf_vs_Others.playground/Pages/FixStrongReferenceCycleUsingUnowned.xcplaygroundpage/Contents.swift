//: [Previous](@previous)

import XCTest

final class HTMLElement: Sendable {
    let name: String
    let text: String?
    
    // () -> String, or “a function that takes no parameters, and returns a String value”.
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class HTMLElementTests: XCTestCase {
    func testSUTSuccessfullyDeInitializedAfterUse() {
        // `sut` here means system under test and `HTMLElement` is our SUT here.
        let sut = makeSUT(name: "p", text: "Hello, World!")
        
        XCTAssertEqual(sut.asHTML(), "<p>hello, world</p>")
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

//: [Next](@next)
