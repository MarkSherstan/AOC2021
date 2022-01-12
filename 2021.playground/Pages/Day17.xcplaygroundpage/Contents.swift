import Foundation

let startTime = NSDate()

let day17 = Day17()
day17.part1()
day17.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
