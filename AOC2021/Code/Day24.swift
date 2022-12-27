//
//  Day24.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-12-26.
//

import Foundation

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

class Day24 {
    var monad: [Substring]
    
    init() {
        // Load in data
        let url = Bundle.main.url(forResource: "Day24", withExtension: "txt")!
        monad = try! String(contentsOf: url).split(separator: "\n")
    }
    
    func solve(modelNumber: [Int]) -> Bool {
        // Vars start at zero
        var data: [String: Int] = ["w": 0, "x": 0, "y": 0, "z": 0]
        var idx = 0
        
        // Loop through monad instructions
        for mon in monad {
            let parts = mon.components(separatedBy: " ")
            
            if parts[0] == "inp" {
                data["w"] = modelNumber[idx]
                idx += 1
            } else {
                let A = data[parts[1]]!
                var B: Int
                
                if parts[2].isInt {
                    B = Int(parts[2])!
                } else {
                    B = data[parts[2]]!
                }
                                
                switch parts[0] {
                case "add":
                    data[parts[1]] = A + B
                case "mul":
                    data[parts[1]] = A * B
                case "div":
                    data[parts[1]] = Int(A / B)
                case "mod":
                    data[parts[1]] = A % B
                case "eql":
                    if A == B {
                        data[parts[1]] = 1
                    } else {
                        data[parts[1]] = 0
                    }
                default:
                    print("ERROR")
                }
            }
        }
        
        if data["z"]! == 0 {
            return true
        } else {
            return false
        }
    }
    
    func numGen() {
        for i in (1...99999999999999).reversed() {
            let strNum = String(i)
            
            if !strNum.contains("0") {
                if solve(modelNumber: strNum.compactMap { Int(String($0)) }) {
                    print(i)
                    break
                }
                print(i)
            }
        }
    }
    
    /// Part 1
    func part1() -> String {
        numGen()
        return "A"
    }
    
    /// Part 2
    func part2() -> String {
        
        return "B"
    }
}
