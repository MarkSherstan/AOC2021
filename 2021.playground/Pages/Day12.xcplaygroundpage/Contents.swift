import Foundation

let startTime = NSDate()

let day12 = Day12()
day12.part1()
day12.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
