/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 # How to test a Singleton candidate
 
 ## <#Description#>
 
 */

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class NetworkManager {
    nonisolated(unsafe) static let shared = NetworkManager()
    private init() {}

    func fetchData(from url: URL) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await URLSession.shared.data(from: url)
        let httpResponse = try response.httpResponse
        
        return (data, httpResponse)
    }
}

let networkManager = NetworkManager.shared

do {
    let (postsData, httpResponse) = try await networkManager.fetchData(from: fetchPostsURL)
    
    let posts = try PostsMapper.map(
        postsData,
        from: httpResponse
    )
    print("First Post: ")
    print(posts.first!)
} catch {
    print("Error: \(error)")
}

PlaygroundPage.current.finishExecution()
