# SwiftPokeKit

A Swift library for interacting with the [PokeAPI](https://pokeapi.co/), providing easy access to Pokémon data. This library is built using Swift Concurrency and requires iOS 15+ and macOS 12+.

## Installation

### Swift Package Manager

Add SwiftPokeKit as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/SwiftPokeKit.git", .upToNextMajor(from: "1.0.0"))
]
```
Don't forget to add SwiftPokeKit to your target dependencies:
```swift
.target(name: "YourApp", dependencies: ["SwiftPokeKit"]),
```

## Usage
### Import SwiftPokeKit
First, import SwiftPokeKit in the file where you want to use it:

```swift
import SwiftPokeKit
```
### Create a PokeAPIClient instance
Initialize a PokeAPIClient instance:
```swift
let pokeAPIClient = PokeAPIClient()
```
### Fetch a Pokémon by Name
To fetch a Pokémon by name, call the fetchPokemon(name:) function:

```swift
async {
    do {
        let pokemon = try await pokeAPIClient.fetchPokemon(name: "pikachu")
        print("Fetched Pokémon: \(pokemon.name)")
    } catch {
        print("Error fetching Pokémon: \(error)")
    }
}
```

## Contributing
We welcome contributions! Feel free to submit pull requests, report issues, or suggest new features.

## License
SwiftPokeKit is available under the MIT license. See the LICENSE file for more details.
