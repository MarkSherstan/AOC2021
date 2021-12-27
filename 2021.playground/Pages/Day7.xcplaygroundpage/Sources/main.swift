import Foundation

public class Day7 {
    var crabPosition: [Int]
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
        self.crabPosition = try! String(contentsOf: url).replacingOccurrences(of: "\n", with: "").split(separator: ",").compactMap{ Int($0) }
    }
    
    // Crabs only walk sideways
    func run(isPart2: Bool) -> Int {
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
            
            if isPart2 {
                fuelArray = fuelArray.map{sumDict[$0]!}
            }
            
            results.append(fuelArray.reduce(0, +))
        }
        
        return results.min()!
    }
    
    // Part 1
    public func part1() {
        print("Part 1: ", run(isPart2: false))
    }
    
    // Part 2
    public func part2() {
        print("Part 2: ", run(isPart2: true))
    }
}
