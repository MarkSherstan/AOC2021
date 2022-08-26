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
        case "Day 11":
            let d11 = Day11()
            p1 = d11.part1()
            p2 = d11.part2()
        case "Day 12":
            let d12 = Day12()
            p1 = d12.part1()
            p2 = d12.part2()
        case "Day 13":
            let d13 = Day13()
            p1 = d13.part1()
            p2 = d13.part2()
        case "Day 14":
            let d14 = Day14()
            p1 = d14.part1()
            p2 = d14.part2()
        case "Day 15":
            let d15 = Day15()
            p1 = d15.part1()
            p2 = d15.part2()
        case "Day 16":
            let d16 = Day16()
            p1 = d16.part1()
            p2 = d16.part2()
        case "Day 17":
            let d17 = Day17()
            p1 = d17.part1()
            p2 = d17.part2()
        case "Day 18":
            let d18 = Day18()
            p1 = d18.part1()
            p2 = d18.part2()
        case "Day 19":
            let d19 = Day19()
            p1 = d19.part1()
            p2 = d19.part2()
        case "Day 20":
            let d20 = Day20()
            p1 = d20.part1()
            p2 = d20.part2()
        case "Day 21":
            let d21 = Day21()
            p1 = d21.part1()
            p2 = d21.part2()
        case "Day 22":
            let d22 = Day22()
            p1 = d22.part1()
            p2 = d22.part2()
        case "Day 23":
            let d23 = Day23()
            p1 = d23.part1()
            p2 = d23.part2()
        default:
            p1 = "NA"
            p2 = "NA"
        }
        
        let solveTime = String(format:"%.3f", self.timeElapsed())
        
        return (p1, p2, solveTime)
    }
}
