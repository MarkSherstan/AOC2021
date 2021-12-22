import Foundation

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let crabPosition = try String(contentsOf: url).replacingOccurrences(of: "\n", with: "").split(separator: ",").compactMap{ Int($0) }

// Precalculate sums
var sumDict: [Int: Int] = [:]
var sum = 0

for i in 0...crabPosition.max()! {
    sum += i
    sumDict[i] = sum
}

// Calc
var results = [Int]()
var singlePos = [Int]()
var fuelArray = [Int]()

for crab in 0..<crabPosition.max()! {
    singlePos = Array(repeating: crab, count: crabPosition.count)
    fuelArray = zip(crabPosition, singlePos).map{abs($0 - $1)}
    fuelArray = fuelArray.map{sumDict[$0]!}
    results.append(fuelArray.reduce(0, +))
    print(crab, crabPosition.max()!)
}

print("Part 1 | 2: ", results.min()!)
