import Cocoa

// Import depths
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let text = try String(contentsOf: url).split(separator: "\n")
let sonarDepths = text.compactMap{ Int($0) }

// Count depth increases
var depthCount = 0

for i in 0..<(sonarDepths.count-1) {
    if sonarDepths[i+1] - sonarDepths[i] > 0 {
        depthCount += 1
    }
}

// Print result
print(depthCount)
