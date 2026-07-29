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
            if instance == nil {
                print("✅ \(T.self) deallocated cleanly - no retain cycle")
            } else {
                print("❌ \(T.self) is still in memory - retain cycle detected")
            }
            XCTAssertNil(
                instance,
                "Instance should have been deallocated. Potential memory leak.",
                file: file,
                line: line
            )
        }
    }
}
