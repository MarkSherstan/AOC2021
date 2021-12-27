import Foundation

// Fish class
class LanternFish {
    var timer: Int
    
    init(timer: Int) {
        self.timer = timer
    }
        
    func age() -> Bool {
        if self.timer == 0 {
            self.timer = 6
            return true
        } else {
            self.timer -= 1
            return false
        }
    }
}

public class Day6 {
    var timers: [Int]
    
    // Read in data
    public init() {
        let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
        self.timers = try! String(contentsOf: url).replacingOccurrences(of: "\n", with: "").split(separator: ",").compactMap{ Int($0) }
    }
    
    // Time array builder
    func timerBuilder(timer: Int, days: Int) -> [Int] {
        var lanternFishArray = [LanternFish(timer: timer)]

        for _ in 0..<days {
            for fish in lanternFishArray {
                if fish.age() {
                    (lanternFishArray.append(LanternFish(timer: 8)))
                }
            }
        }
        
        var timerArray = [Int]()
        
        for fish in lanternFishArray {
            timerArray.append(fish.timer)
        }
        
        return timerArray
    }

    // Simulate the expotential growth
    func simulate(numDays: Int) -> Int {
        // Dictionary init
        var growth50: [Int: Int] = [:]
        var growth100: [Int: Int] = [:]

        // Calculate the first half of simulation for every age of fish and save to dictionary
        var master = [[Int]]()

        for i in 0...8 {
            master.append([Int]())
            master[i].append(contentsOf: timerBuilder(timer: i, days: numDays/2))
        }

        for i in 0...8 {
            growth50[i] = master[i].count
        }

        // Use the results of the first half to calculate the second half of simulation
        for i in 0...8 {
            let temp = master[i]
            
            var total = 0
            for entry in temp {
                total += growth50[entry]!
            }
            
            growth100[i] = total
        }

        // Use pre calculated numbers on actual data set
        var total = 0
        for timer in timers {
            total += growth100[timer]!
        }

        return total
    }
    
    // Part 1
    public func part1() {
        print("Part 1: ", simulate(numDays: 80))
    }
    
    // Part 2
    public func part2() {
        print("Part 2: ", simulate(numDays: 256))
    }
}
