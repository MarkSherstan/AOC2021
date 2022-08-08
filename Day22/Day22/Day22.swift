//
//  Day22.swift
//  Day22
//
//  Created by Mark Sherstan on 2022-08-01.
//

import Foundation

class Day22 {
    // Timer
    var startTime: DispatchTime!
    
    // Outputs
    var test1: Int = 0
    var test2: Int = 0
    var part1: Int = 0
    var part2: Int = 0
    
    // Data
    var instructions: [([Int], Int)] = []

    // Begin a timer
    func startTimer() {
        self.startTime = DispatchTime.now()
    }
    
    // Calculate time elapsed since begin was called
    func timeElapsed() -> Double {
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - self.startTime.uptimeNanoseconds
        return Double(nanoTime) / 1_000_000_000
    }
    
    func readFile() {
        // Import data
        let url = Bundle.main.url(forResource: "test", withExtension: "txt")!
        let rawData = try! String(contentsOf: url).split(separator: "\n")
        
        for dat in rawData {
            let stateVertexSplit = dat.split(separator: " ")
            
            let vertexStringArray = stateVertexSplit[1].replacingOccurrences(of: "x=", with: "").replacingOccurrences(of: "y=", with: "").replacingOccurrences(of: "z=", with: "").replacingOccurrences(of: "..", with: ",").split(separator: ",")
    
            let vertexArray = vertexStringArray.map { Int($0)!}
            
            if stateVertexSplit[0] == "on" {
                self.instructions.append((vertexArray, 1))
            } else {
                self.instructions.append((vertexArray, -1))
            }
        }
    }
    
    // Test example for Part 1
    func updateTest1() -> (sol: Int, time: Double) {
        self.startTimer()
        self.test1 += 1
        self.readFile()
        
        var cubes: [[Int]:Int] = [:]
        
        for instr in self.instructions {
            // Variables
            var temp: [[Int]:Int] = [:]
            let vertex = instr.0
            let state = instr.1
            
            // Loop throug cubes that we have saved comparing to the input
            for (v, s) in cubes {
                // See if there is overlap (max of left sides (mins) has to be less than min of right sides (maxs)).
                // There are 6 possible cases, 4 of which are bounded and 2 which are not bounded. Bounded example:
                //        |            |            |            |
                //        |            |            |            |
                //     Vertex[0]      V[0]      Vertex[1]       V[1]
                let x0 = max(vertex[0], v[0])
                let x1 = min(vertex[1], v[1])
                let y0 = max(vertex[2], v[2])
                let y1 = min(vertex[3], v[3])
                let z0 = max(vertex[4], v[4])
                let z1 = min(vertex[5], v[5])
                
                if ((x0 <= x1) && (y0 <= y1) && (z0 <= z1)) {
                    // Save the bounded area with opposite sign
                    if temp[[x0, x1, y0, y1, z0, z1]] == nil {
                        temp[[x0, x1, y0, y1, z0, z1]] = -s
                    } else {
                        temp[[x0, x1, y0, y1, z0, z1]]! -= s
                    }
                }
            }
            
            // Add vertices if it is "on"
            if (state > 0) {
                if temp[vertex] == nil {
                    temp[vertex] = state
                } else {
                    temp[vertex]! += state
                }
            }
            
            // Add results from temp into cubes list for next itteration
            for (key, val) in temp {
                if cubes[key] == nil {
                    cubes[key] = val
                } else {
                    cubes[key]! += val
                }
            }
        }
        
        // Calculate volume
        var total = 0
        for (vertex, multiplier) in cubes {
            total += (vertex[1] - vertex[0] + 1) * (vertex[3] - vertex[2] + 1) * (vertex[5] - vertex[4] + 1) * multiplier
        }
        
        print(total)

        let time = self.timeElapsed()
        return (self.test1, time)
    }
    
    // Test example for Part 2
    func updateTest2() -> (sol: Int, time: Double) {
        self.startTimer()
        self.test2 += 2
        let time = self.timeElapsed()
        return (self.test2, time)
    }
    
    // Part 1
    func updatePart1() -> (sol: Int, time: Double) {
        self.startTimer()
        self.part1 += 5
        let time = self.timeElapsed()
        return (self.part1, time)
    }
    
    // Part 2
    func updatePart2() -> (sol: Int, time: Double) {
        self.startTimer()
        self.part2 += 1000
        let time = self.timeElapsed()
        return (self.part2, time)
    }
}
