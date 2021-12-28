import Foundation

let startTime = NSDate()

let day8 = Day8()
day8.part1()
day8.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
