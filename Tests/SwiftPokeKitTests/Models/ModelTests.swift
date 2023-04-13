import XCTest

@testable import SwiftPokeKit

final class ModelTests: XCTestCase {
    
    func testDecodePokemon() throws {
        let jsonData = """
        {
            "id": 25,
            "name": "pikachu",
            "height": 4,
            "weight": 60,
            "abilities": [
                {
                    "is_hidden": false,
                    "slot": 1,
                    "ability": {
                        "name": "static",
                        "url": "https://pokeapi.co/api/v2/ability/9/"
                    }
                }
            ],
            "types": [
                {
                    "slot": 1,
                    "type": {
                        "name": "electric",
                        "url": "https://pokeapi.co/api/v2/type/13/"
                    }
                }
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let pokemon = try decoder.decode(Pokemon.self, from: jsonData)
        
        XCTAssertEqual(pokemon.id, 25)
        XCTAssertEqual(pokemon.name, "pikachu")
        XCTAssertEqual(pokemon.height, 4)
        XCTAssertEqual(pokemon.weight, 60)
        
        XCTAssertEqual(pokemon.abilities.count, 1)
        XCTAssertEqual(pokemon.abilities[0].slot, 1)
        XCTAssertEqual(pokemon.abilities[0].isHidden, false)
        XCTAssertEqual(pokemon.abilities[0].ability.name, "static")
        XCTAssertEqual(pokemon.abilities[0].ability.url, URL(string: "https://pokeapi.co/api/v2/ability/9/")!)
        
        XCTAssertEqual(pokemon.types.count, 1)
        XCTAssertEqual(pokemon.types[0].slot, 1)
        XCTAssertEqual(pokemon.types[0].type.name, "electric")
        XCTAssertEqual(pokemon.types[0].type.url, URL(string: "https://pokeapi.co/api/v2/type/13/")!)
    }
}
