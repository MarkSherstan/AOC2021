import Foundation

// Import directions
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let diagnosticReport = try String(contentsOf: url).split(separator: "\n")

// Variables
var gamma = ""
var epsilon = ""

// Extract data
func trueCounter(report: Array<Substring>, bits: Int) -> Array<Int> {
    var bitTrueCount = Array(repeating: 0, count: bits)
    
    for i in 0..<report.count {
        let temp = Array(report[i])

        for j in 0..<bits {
            bitTrueCount[j] += Int(String(temp[j]))!
        }
    }
    
    return bitTrueCount
}

var bitTrueCount = trueCounter(report: diagnosticReport, bits: diagnosticReport[0].count)

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

// O2 -> This is some sloppy code... Should be a function...
var diagnosticReportTemp: [Substring] = []
var reportO2 = diagnosticReport

// Loop through diagnostics (semi recursive)
for i in 0..<reportO2[0].count {
    bitTrueCount = trueCounter(report: reportO2, bits: reportO2[0].count)
    
    // Only save data we are interested in
    if bitTrueCount[i] >= reportO2.count - bitTrueCount[i] {
        for j in 0..<reportO2.count {
            let temp = Array(reportO2[j])

            if temp[i] == "1" {
                diagnosticReportTemp.append(reportO2[j])
            }
        }
    } else {
        for j in 0..<reportO2.count {
            let temp = Array(reportO2[j])

            if temp[i] == "0" {
                diagnosticReportTemp.append(reportO2[j])
            }
        }
    }
    
    // Save results from loop and reset
    reportO2 = diagnosticReportTemp
    diagnosticReportTemp = []

    // Exit strategy
    if reportO2.count == 1 {
        break
    }
}

let O2 = Int(String(reportO2[0]), radix: 2)

// CO2 -> This is some sloppy code... Should be a function...
diagnosticReportTemp = []
var reportCO2 = diagnosticReport

// Loop through diagnostics (semi recursive)
for i in 0..<reportCO2[0].count {
    bitTrueCount = trueCounter(report: reportCO2, bits: reportCO2[0].count)
    
    // Only save data we are interested in
    if bitTrueCount[i] >= reportCO2.count - bitTrueCount[i] {
        for j in 0..<reportCO2.count {
            let temp = Array(reportCO2[j])

            if temp[i] == "0" {
                diagnosticReportTemp.append(reportCO2[j])
            }
        }
    } else {
        for j in 0..<reportCO2.count {
            let temp = Array(reportCO2[j])

            if temp[i] == "1" {
                diagnosticReportTemp.append(reportCO2[j])
            }
        }
    }
    
    // Save results from loop and reset
    reportCO2 = diagnosticReportTemp
    diagnosticReportTemp = []

    // Exit strategy
    if reportCO2.count == 1 {
        break
    }
}

let CO2 = Int(String(reportCO2[0]), radix: 2)

// Results
print("Part 2: ", O2! * CO2!)
