/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 # Singleton
 
 ## <#Description#>
 
 */

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
}
