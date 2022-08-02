//
//  Part1.swift
//  Day22
//
//  Created by Mark Sherstan on 2022-08-01.
//

import Foundation
import Algorithms

class Part1 {
    // Timer
    var startTime: DispatchTime!
    
    //
    var test1: Int = 0
    var test2: Int = 5
//    @Published var part1: Int = 0
//    @Published var part2: Int = 0
    
    func startTimer() {
        self.startTime = DispatchTime.now()
    }
    
    func timeElapsed() -> Double {
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - self.startTime.uptimeNanoseconds
        return Double(nanoTime) / 1_000_000_000
    }
    
    func updateTest1() -> (sol: Int, time: Double) {
        self.startTimer()
        self.test1 += 1
        let time = self.timeElapsed()
        return (self.test1, time)
    }
    
    func updateTest2() -> Int {
        self.test2 += 1
        return self.test2
    }
}
