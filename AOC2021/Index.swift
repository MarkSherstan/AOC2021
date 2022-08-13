//
//  Index.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-08-11.
//

import Foundation

class Index {
    // Variables
    let days = ["Day1", "Day2"]
    var startTime: DispatchTime!
    
    /// Begin a timer.
    func startTimer() {
        self.startTime = DispatchTime.now()
    }
    
    /// Calculate time elapsed since `startTimer()` was called.
    ///  - Returns: Time elapsed in seconds
    func timeElapsed() -> Double {
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - self.startTime.uptimeNanoseconds
        return Double(nanoTime) / 1_000_000_000
    }
    
    /// Solve a speficied AOC day.
    /// - Parameter day: The AOC day to solve
    /// - Returns: Part 1 and 2 solution and the duration to solve the problems in seconds
    func run(day: String) -> (p1: String, p2: String, solveTime: String) {
        // Init vars and start timer
        var p1: String
        var p2: String
        self.startTimer()
        
        // Run desired code
        switch day {
        case "Day1":
            let d1 = Day1()
            p1 = d1.part1()
            p2 = d1.part2()
        case "Day2":
            let d2 = Day2()
            p1 = d2.part1()
            p2 = d2.part2()
        default:
            print("Not a valid day")
            p1 = "NA"
            p2 = "NA"
        }
        
        let solveTime = String(format:"%.3f", self.timeElapsed())
        
        return (p1, p2, solveTime)
    }
}
