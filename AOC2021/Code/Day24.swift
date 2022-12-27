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
            print(i)
            
//            let strNum = String(i)
//
//            if !strNum.contains("0") {
//                if solve(modelNumber: strNum.compactMap { Int(String($0)) }) {
//                    print(i)
//                    break
//                }
//                print(i)
//            }
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


// Breakdown:
//    inp w       w = w
//    mul x 0     x = 0
//    add x z     x = z
//    mod x 26    x = z % 26
//    div z [A]   z = z / A
//    add x [B]   x = (z % 26) + B
//    eql x w     x = ((z % 26) + B) == w
//    eql x 0     x = (((z % 26) + B) == w) == 0
//    mul y 0     y = 0
//    add y 25    y = 25
//    mul y x     y = 25 * (((z % 26) + B) == w) == 0
//    add y 1     y = [25 * (((z % 26) + B) == w) == 0] + 1
//    mul z y     z = (z / A) * {[25 * (((z % 26) + B) == w) == 0] + 1}
//    mul y 0     y = 0
//    add y w     y = w
//    add y [C]   y = w + C
//    mul y x     y = (w + C) * [(((z % 26) + B) == w) == 0]
//    add z y     z = (z / A) + (w + C) * [(((z % 26) + B) == w) == 0]

// Simplification:
//    w = input
//    x = ((z % 26) + B) != w
//    z = Int(z/A)
//    z *= (25*x + 1)
//    z += (w+C)*x

// Coeffcients:
//    A    B    C
//    ------------
//    1    10   12
//    1    12   7
//    1    10   8
//    1    12   8
//    1    11   15
//    26  -16   12
//    1    10   8
//    26  -11   13
//    26  -13   3
//    1    13   13
//    26  -8    3
//    26  -1    9
//    26  -4    4
//    26  -14   13

// Simplification 2:
//    For the case: A == 1 -> (10 <= B <= 13)
//
//    w = input
//    x = ((z % 26) + B) != w -> Must be true otherwise we never get 0
//    z = Int(z/A) -> A is 1, this is not a required operation
//    z *= (25*x + 1)
//    z += (w+C)*x
//
//    w = input
//    z *= 26
//    z += (w+C)
//
//    z = (z * 26) + w + C
