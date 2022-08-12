//
//  Index.swift
//  AOC2021
//
//  Created by Mark Sherstan on 2022-08-11.
//

import Foundation

class Index {
    
    func run(day: String) {
        switch day {
        case "Day1":
            let d1 = Day1()
            d1.part1()
            d1.part2()
            print("Day 1")
            
        case "Day2":
            let d2 = Day2()
            d2.part1()
            d2.part2()
            
            print("Day 2")
        default:
            print("Not valid")
        }
        
        //-> (p1: String, p2: String, time: String)
    }
}
