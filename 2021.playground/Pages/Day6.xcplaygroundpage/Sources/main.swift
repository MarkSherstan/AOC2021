import Foundation

public class PlayGround {
    public class func run() {
        // Import data
        let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
        let timers = try! String(contentsOf: url).replacingOccurrences(of: "\n", with: "").split(separator: ",").compactMap{ Int($0) }

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

        // Split progress into two sectors
        var QQ: [Int: Int] = [:]
        var QQQ: [Int: Int] = [:]

        // Build array
        var master = [[Int]]()

        for i in 0...8 {
            master.append([Int]())
            master[i].append(contentsOf: timerBuilder(timer: i, days: 128)) // Change to 80 for part 1
        }

        for i in 0...8 {
            QQ[i] = master[i].count
        }

        // Full progress
        for i in 0...8 {
            let temp = master[i]
            
            var total = 0
            for A in temp {
                total += QQ[A]!
            }
            
            QQQ[i] = total
        }

        // Result
        var total = 0
        for timer in timers {
            total += QQQ[timer]!
        }

        print(total)
    }
}
