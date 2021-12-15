import Cocoa

// Import depths
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let text = try String(contentsOf: url).split(separator: "\n")
let sonarDepths = text.compactMap{ Int($0) }

// Window the depths
var sonarDepthsWindow = [Int]()

for i in 0..<(sonarDepths.count-2) {
    sonarDepthsWindow.append(sonarDepths[i] + sonarDepths[i+1] + sonarDepths[i+2])
}

// Depth counter function
func depthCounter(sonarDepthArray: Array<Int>) -> Int {
    var depthCount = 0
    
    for i in 0..<(sonarDepthArray.count-1) {
        if sonarDepthArray[i+1] - sonarDepthArray[i] > 0 {
            depthCount += 1
        }
    }
    
    return depthCount
}

// Print result
print("Part 1: ", depthCounter(sonarDepthArray: sonarDepths))
print("Part 2: ", depthCounter(sonarDepthArray: sonarDepthsWindow))
