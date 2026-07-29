/*:
 ## Tracking potential memory leaks using XCTestCase extension in playgrounds
 */

import XCTest

public extension XCTestCase {
    func trackForMemoryLeaks<T: AnyObject & Sendable>(
        _ instance: T,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "❌ Instance should have been deallocated. Potential memory leak.",
                file: file,
                line: line
            )
        }
    }
}
