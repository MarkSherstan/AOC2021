import Foundation

// Import data
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let timers = try String(contentsOf: url).replacingOccurrences(of: "\n", with: "").split(separator: ",").compactMap{ Int($0) }

// Initial conditions
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

var lanternFish = [LanternFish]()
for timer in timers {
    lanternFish.append(LanternFish(timer: timer))
}

// Loop through 80 days
for _ in 0..<80 {
    for fish in lanternFish {
        if fish.age() {
            (lanternFish.append(LanternFish(timer: 8)))
        }
    }
}

print("Part 1: ", lanternFish.count)
