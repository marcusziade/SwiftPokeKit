import Foundation

public struct TypeSlot: Codable {
    public let slot: Int
    public let type: Type
}

public struct Type: Codable {
    public let id: Int
    public let name: String
    public let url: String
}
