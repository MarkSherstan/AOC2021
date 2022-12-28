//
//  Day24.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-12-26.
//

import Foundation

class Day24 {
    // Create struct and array holding A, B, C constants
    struct Constants {
        var A: Int
        var B: Int
        var C: Int
    }
    var constArray: [Constants] = []
    
    init() {
        // Load in data
        let url = Bundle.main.url(forResource: "Day24", withExtension: "txt")!
        let monad = try! String(contentsOf: url).split(separator: "\n")
        let monadChunk = monad.chunked(into: 18)
        
        // Extract and save
        var A, B, C: Int
        for chunk in monadChunk {
            A = Int(chunk[4].components(separatedBy: " ")[2])!
            B = Int(chunk[5].components(separatedBy: " ")[2])!
            C = Int(chunk[15].components(separatedBy: " ")[2])!
            constArray.append(Constants(A: A, B: B, C: C))
        }
    }
    
    /// Solver (see breakdown comments below)
    func solve(modelNumber: inout [Int]) -> String {
        var stack: [(Int, Int)] = []
        var sol = ""
        
        for (i, const) in constArray.enumerated() {
            if const.A == 1 {
                stack.append((i, const.C))
            } else if const.A == 26 {
                let (j, C) = stack.removeLast()
                modelNumber[i] = modelNumber[j] + C + const.B
               
                if modelNumber[i] > 9 {
                    modelNumber[j] -= (modelNumber[i] - 9)
                    modelNumber[i] = 9
                } else if modelNumber[i] < 1 {
                    modelNumber[j] += (1 - modelNumber[i])
                    modelNumber[i] = 1
                }
            }
        }
        _ = modelNumber.map{ sol = sol + "\($0)" }
        return sol
    }
    
    /// Part 1
    func part1() -> String {
        var base = Array(repeating: 9, count: 14)
        return solve(modelNumber: &base)
    }
    
    /// Part 2
    func part2() -> String {
        var base = Array(repeating: 1, count: 14)
        return solve(modelNumber: &base)
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
//    x = ((z % 26) + B) != w -> (B > 10 and w < 9 therefore always 1)
//    z = Int(z/A) -> A is 1, this is not a required operation
//    z *= (25*x + 1)
//    z += (w+C)*x
//
//    w = input
//    z *= 26
//    z += (w+C)
//
//    z = (z * 26) + w + C
//
//
//
//    For the case: A == 26
//
//    w = input
//    x = ((z % 26) + B) != w -> This must be zero for a solution (z will carry through)
//    z = Int(z/A) -> A will be 26
//    z *= (25*x + 1)
//    z += (w+C)*x
//
//    w = input
//    x = ((z % 26) + B) != w   ->   Must be zero (should equal) was also *26 so   ->  (w_i + C) + B == w _new
//    z = Int(z/26)     -> Int((w_i + C) / 26) = 0
//    z *= (25*x + 1)   -> 0
//    z += (w+C)*x      -> 0
//
//
//    Therefore the magic equation with pushes and pops is: (w_i + C) + B == w _new
