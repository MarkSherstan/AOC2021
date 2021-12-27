import Foundation

public class Day3 {
    var diagnosticReport: [Substring]
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
        self.diagnosticReport = try! String(contentsOf: url).split(separator: "\n")
    }
    
    // Sum columns
    func sumColumns(report: [Substring]) -> [Int] {
        let cols = report[0].count
        var result = Array(repeating: 0, count: cols)
        
        for entry in report {
            let temp = Array(entry)
            
            for i in 0..<cols {
                result[i] += Int(String(temp[i]))!
            }
        }
        
        return result
    }
    
    // Life support calculator
    func lifeSupportRating(report: inout [Substring], isO2: Bool) -> Int {
        var reportTemp = [Substring]()
        
        // Loop through diagnostics (semi recursive)
        for i in 0..<report[0].count {
            let colSum = sumColumns(report: report)
            
            // Only save data we are interested in
            if colSum[i] >= report.count - colSum[i] {
                for j in 0..<report.count {
                    let temp = Array(report[j])
                    
                    if isO2 {
                        if temp[i] == "1" {
                            reportTemp.append(report[j])
                        }
                    } else {
                        if temp[i] == "0" {
                            reportTemp.append(report[j])
                        }
                    }
                }
            } else {
                for j in 0..<report.count {
                    let temp = Array(report[j])
                    
                    if isO2 {
                        if temp[i] == "0" {
                            reportTemp.append(report[j])
                        }
                    } else {
                        if temp[i] == "1" {
                            reportTemp.append(report[j])
                        }
                    }
                }
            }
            
            // Save results from loop and reset temp
            report = reportTemp
            reportTemp.removeAll()
            
            // Exit strategy
            if report.count == 1 {
                break
            }
        }
        
        return Int(String(report[0]), radix: 2)!
    }
    
    // Part 1
    public func part1() {
        // Variables
        var gamma = ""
        var epsilon = ""
        
        // Sum columns and assign gamma or epsilon
        let colSum = sumColumns(report: diagnosticReport)
        
        for col in colSum {
            if col > diagnosticReport.count - col {
                gamma.append("1")
                epsilon.append("0")
            } else {
                gamma.append("0")
                epsilon.append("1")
            }
        }
        
        // Convert from binary to decimal
        let gammaNum = Int(gamma, radix: 2)
        let epsilonNum = Int(epsilon, radix: 2)
        
        // Results
        print("Part 1: ", gammaNum! * epsilonNum!)
    }
    
    // Part 2
    public func part2() {
        var reportO2 = diagnosticReport
        var reportCO2 = diagnosticReport
        
        let O2 = lifeSupportRating(report: &reportO2, isO2: true)
        let CO2 = lifeSupportRating(report: &reportCO2, isO2: false)
        
        print("Part 2: ", O2 * CO2)
    }
}
