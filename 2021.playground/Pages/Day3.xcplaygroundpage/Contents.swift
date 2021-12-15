import Foundation

// Import directions
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let diagnosticReport = try String(contentsOf: url).split(separator: "\n")

// Variables
let bits = diagnosticReport[0].count
var bitTrueCount = Array(repeating: 0, count: bits)
var gamma = ""
var epsilon = ""

// Extract data
for i in 0..<diagnosticReport.count {
    let temp = Array(diagnosticReport[i])

    for j in 0..<bits {
        bitTrueCount[j] += Int(String(temp[j]))!
    }
}

// Gamma and epsilon
for i in 0..<bitTrueCount.count {
    if bitTrueCount[i] > diagnosticReport.count - bitTrueCount[i] {
        gamma.append("1")
        epsilon.append("0")
    } else {
        gamma.append("0")
        epsilon.append("1")
    }
}

let gammaNum = Int(gamma, radix: 2)
let epsilonNum = Int(epsilon, radix: 2)

// Results
print("Part 1: ", gammaNum! * epsilonNum! )
