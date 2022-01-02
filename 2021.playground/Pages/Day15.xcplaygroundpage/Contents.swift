import Foundation

let startTime = NSDate()

let day15 = Day15()
day15.part1()
day15.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
