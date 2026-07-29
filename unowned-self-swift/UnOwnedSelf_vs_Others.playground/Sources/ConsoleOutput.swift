import Foundation


/// Prints a labeled header stating the capture style under test and the
/// expected outcome, then runs the suite - so each page's console output
/// reads as a titled comparison instead of raw XCTest noise.
///
/// - Parameters:
///   - captureStyle: The self-capture style being demonstrated (e.g. "weak self").
///   - outcome: The expected result of running the suite (e.g. "sut deallocates cleanly").
///   - run: A closure that runs the suite of tests for the capture style being demonstrated.
public func demo(
    _ captureStyle: String,
    expecting outcome: String,
    run: () -> Void
) {
    print("""
    
    ═══════════════════════════════════════
    🔍 \(captureStyle)
    ⏳ Expecting: \(outcome)
    ═══════════════════════════════════════
    """)
    run()
}
