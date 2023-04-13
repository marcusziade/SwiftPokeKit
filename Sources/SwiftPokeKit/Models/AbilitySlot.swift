import Foundation

public struct AbilitySlot: Codable {
    public let slot: Int
    public let isHidden: Bool
    public let ability: Ability
}

public struct Ability: Codable {
    public let name: String
    public let url: URL
}
