import Foundation
import PlaygroundSupport
import _Concurrency

PlaygroundPage
    .current
    .needsIndefiniteExecution = true


func calculateFullName(
    firstName: String,
    lastName: String
) async -> String {
    try? await Task.sleep(for: .seconds(1))
    return "\(firstName) \(lastName)"
}

Task {
    let result1 = await calculateFullName(firstName: "Foo", lastName: "Bar")
    async let result2 = calculateFullName(firstName: "Foo", lastName: "Bar")
    
    await result2
}



enum Clothe {
    case socks, shirt, trousers
}

func buySocks() async throws -> Clothe {
    try await Task.sleep(for: .seconds(1))
    return Clothe.socks
}
func buyShirt() async throws -> Clothe {
    try await Task.sleep(for: .seconds(1))
    return Clothe.shirt
}

func buyTrousers() async throws -> Clothe {
    try await Task.sleep(for: .seconds(1))
    return Clothe.shirt
}

struct Ensemble: CustomDebugStringConvertible{
    let clothes: [Clothe]
    let totalPrice: Double
    
    var debugDescription: String {
        "Clothes = \(clothes), prince = \(totalPrice)"
    }
}

func buyWholeEnsemble() async throws -> Ensemble {
    async let sock = buySocks()
    async let shirt = buyShirt()
    async let trousers = buyTrousers()
    
    let ensemble = Ensemble(
        clothes: await [
            try sock,
            try shirt,
            try trousers
        ],
        totalPrice: 200
    )
    return ensemble
}

Task {
    if let ensemble = try? await buyWholeEnsemble() {
        ensemble
    } else {
        print("Somehting went wrong")
    }
}

func getFullName(
    delay: Duration,
    calculator: () async -> String
) async -> String {
    try? await Task.sleep(for: delay)
    return await calculator()
}


func fullName() async -> String {"Foo Bar"}

Task {
    
    /// Trailing closure
    await getFullName(delay: .seconds(1)) {
        async let name = fullName()
        return await name
    }
}
