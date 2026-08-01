/*:
 [< Previous](@previous)                    [Home](<#Introduction#>)                    [Next >](@next)
 ## Proof Of Concept
 <#Description#>
 */

//: Execute async code

import _Concurrency

Task {
    try await Task.sleep(nanoseconds: 2_000_000_000)
    print("Hello world")
}
