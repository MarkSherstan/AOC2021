import Foundation

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let data = try String(contentsOf: url)

// Format Data
let dataSplit = data.split(separator: "\n")

var pattern = [String]()
var output = [String]()

for dat in dataSplit {
    let temp = dat.split(separator: "|")
    pattern.append(String(temp[0]))
    output.append(String(temp[1]))
}

// Process
var total = 0

for out in output {
    let temp = out.split(separator: " ")
    
    for digit in temp {
        if (digit.count == 2) || (digit.count == 3) || (digit.count == 4) || (digit.count == 7) {
            total += 1
        }
    }
}

// Print results
print("Part 1:", total)
