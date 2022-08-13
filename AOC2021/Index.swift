//
//  Index.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-08-11.
//

import Foundation

class Index {
    // Variables
    var days: [String] = []
    var startTime: DispatchTime!
    
    // Init
    init(numDays: Int) {
        for i in 1...numDays {
            self.days.append("Day " + String(i))
        }
    }
    
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
        case "Day 1":
            let d1 = Day1()
            p1 = d1.part1()
            p2 = d1.part2()
        case "Day 2":
            let d2 = Day2()
            p1 = d2.part1()
            p2 = d2.part2()
        case "Day 3":
            let d3 = Day3()
            p1 = d3.part1()
            p2 = d3.part2()
        case "Day 4":
            let d4 = Day4()
            p1 = d4.part1()
            p2 = d4.part2()
        case "Day 5":
            let d5 = Day5()
            p1 = d5.part1()
            p2 = d5.part2()
        case "Day 6":
            let d6 = Day6()
            p1 = d6.part1()
            p2 = d6.part2()
        case "Day 7":
            let d7 = Day7()
            p1 = d7.part1()
            p2 = d7.part2()
        case "Day 8":
            let d8 = Day8()
            p1 = d8.part1()
            p2 = d8.part2()
        case "Day 9":
            let d9 = Day9()
            p1 = d9.part1()
            p2 = d9.part2()
        case "Day 10":
            let d10 = Day10()
            p1 = d10.part1()
            p2 = d10.part2()
        default:
            print("Not a valid day")
            p1 = "NA"
            p2 = "NA"
        }
        
        let solveTime = String(format:"%.3f", self.timeElapsed())
        
        return (p1, p2, solveTime)
    }
}
