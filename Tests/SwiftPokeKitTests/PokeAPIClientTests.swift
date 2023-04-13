import XCTest

@testable import SwiftPokeKit

@available(iOS 15, *)
@available(macOS 12, *)
final class PokeAPIClientTests: XCTestCase {
    var sut: PokeAPIClient!
    
    override func setUp() {
        super.setUp()
        sut = PokeAPIClient()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchPokemon() async throws {
        do {
            let fetchedPokemon = try await sut.fetchPokemon(name: "pikachu")
            XCTAssertEqual(fetchedPokemon.name, "pikachu")
        } catch {
            XCTFail("Failed to fetch Pikachu: \(error)")
        }
    }
    
    func testFetchNonExistentPokemon() async throws {
        do {
            _ = try await sut.fetchPokemon(name: "nonexistentpokemon")
            XCTFail("Expected an error, but the test succeeded")
        } catch {
            // Test passes if an error is thrown for a non-existent Pokémon
        }
    }
}
