//
//  Index.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-08-11.
//

import Foundation

class Index {
    // Variables
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
    func run(day: String) {
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
        
        let time = self.timeElapsed()
        
        print(day, p1, p2, time)
        
        //-> (p1: String, p2: String, time: String)
    }
}
