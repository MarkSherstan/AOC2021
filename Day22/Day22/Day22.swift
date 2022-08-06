//
//  Day22.swift
//  Day22
//
//  Created by Mark Sherstan on 2022-08-01.
//

import Foundation
import Algorithms

// Scanner struct
struct RebootSteps {
    var state: Bool
    var x: ClosedRange<Int>
    var y: ClosedRange<Int>
    var z: ClosedRange<Int>
}

class Day22 {
    // Timer
    var startTime: DispatchTime!
    
    // Outputs
    var test1: Int = 0
    var test2: Int = 0
    var part1: Int = 0
    var part2: Int = 0
    
    // Data
    var steps: [RebootSteps] = []
    
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

        // Vars
        var rebootState: Bool
        
        for dat in rawData {
            let temp = dat.split(separator: " ")
            
            if temp[0] == "on" {
                rebootState = true
            } else {
                rebootState = false
            }
            
            let 🍏 = temp[1].replacingOccurrences(of: "x=", with: "").replacingOccurrences(of: "y=", with: "").replacingOccurrences(of: "z=", with: "").replacingOccurrences(of: "..", with: " ").split(separator: ",")
            
            var 🍉: [ClosedRange<Int>] = []
            for 🍎 in 🍏 {
                let 🍇 = 🍎.split(separator: " ")
                🍉.append(Int(🍇[0])!...Int(🍇[1])!)
            }
            
            let 🥦 = RebootSteps(state: rebootState, x: 🍉[0], y: 🍉[1], z: 🍉[2])
            self.steps.append(🥦)
        }
    }
    
    // Test example for Part 1
    func updateTest1() -> (sol: Int, time: Double) {
        self.startTimer()
        self.test1 += 1
        self.readFile()
        print(self.steps)
        
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
