import XCTest

@testable import SwiftPokeKit

@available(iOS 15, *)
@available(macOS 12, *)
final class APIExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        sut = URLSession.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSuccessfulRequest() async {
        let request = PokemonAPIRequest(name: "pikachu")
        
        do {
            let pokemon = try await sut.request(request)
            XCTAssertEqual(pokemon.name, "pikachu")
            XCTAssertNotNil(pokemon.abilities)
            XCTAssertNotNil(pokemon.types)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testFailedRequest() async {
        let request = PokemonAPIRequest(name: "invalid-pokemon-name")
        
        do {
            let _ = try await sut.request(request)
            XCTFail("Expected an error, but the test succeeded")
        } catch {
            // Test passes if an error is thrown, as expected.
        }
    }
    
    var sut: URLSession!
}
