import Foundation

public struct AbilitySlot: Codable {
    public let slot: Int
    public let isHidden: Bool
    public let ability: AbilityStruct
}

public struct AbilityStruct: Codable {
    public let name: String
    public let url: URL
}
