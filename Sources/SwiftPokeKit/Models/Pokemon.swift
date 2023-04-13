import Foundation

public struct Pokemon: Codable {
    public let id: Int
    public let name: String
    public let height: Int
    public let weight: Int
    public let abilities: [AbilitySlot]
    public let types: [TypeSlot]
}

public struct PokemonAPIRequest: APIRequest {
    public typealias Response = Pokemon
    
    public var method: HTTPMethod { .get }
    public var path: String { "/pokemon/\(name)" }
    public var headers: [String: String]? { nil }
    public var parameters: [String: Any]? { nil }
    
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
