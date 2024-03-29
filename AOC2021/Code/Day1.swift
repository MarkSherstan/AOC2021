import Foundation

public class Day1 {
    var sonarDepths: [Int]
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "Day1", withExtension: "txt")!
        let text = try! String(contentsOf: url).split(separator: "\n")
        self.sonarDepths = text.compactMap{ Int($0) }
    }
    
    // Depth counter function
    func depthCounter(sonarDepthArray: [Int]) -> Int {
        var depthCount = 0
        
        for i in 0..<(sonarDepthArray.count-1) {
            if sonarDepthArray[i+1] - sonarDepthArray[i] > 0 {
                depthCount += 1
            }
        }
        
        return depthCount
    }
    
    // Part 1
    public func part1() -> String {
        return String(depthCounter(sonarDepthArray: sonarDepths))
    }
    
    // Part 2
    public func part2() -> String {
        // Window the depths
        var sonarDepthsWindow = [Int]()
        for i in 0..<(sonarDepths.count-2) {
            sonarDepthsWindow.append(sonarDepths[i] + sonarDepths[i+1] + sonarDepths[i+2])
        }
        
        // Results
        return String(depthCounter(sonarDepthArray: sonarDepthsWindow))
    }
}
