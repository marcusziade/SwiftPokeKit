import Foundation

public struct TypeSlot: Codable {
    public let slot: Int
    public let type: TypeStruct
}

public struct TypeStruct: Codable {
    public let name: String
    public let url: URL
}
