import Foundation

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let crabPosition = try String(contentsOf: url).replacingOccurrences(of: "\n", with: "").split(separator: ",").compactMap{ Int($0) }

// Calc
var results = [Int]()

for crab in crabPosition {
    let singlePos = (Array(repeating: crab, count: crabPosition.count))
    let fuelArray = (zip(crabPosition, singlePos).map{abs($0 - $1)})
    let fuel = (fuelArray.reduce(0, +))
    results.append(fuel)
}

print("Part 1: ", results.min()!)
