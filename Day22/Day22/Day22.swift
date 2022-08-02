//
//  Day22.swift
//  Day22
//
//  Created by Mark Sherstan on 2022-08-01.
//

import Foundation
import Algorithms

class Day22 {
    // Timer
    var startTime: DispatchTime!
    
    // Outputs
    var test1: Int = 0
    var test2: Int = 0
    var part1: Int = 0
    var part2: Int = 0
    
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
    
    // Test example for Part 1
    func updateTest1() -> (sol: Int, time: Double) {
        self.startTimer()
        self.test1 += 1
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
