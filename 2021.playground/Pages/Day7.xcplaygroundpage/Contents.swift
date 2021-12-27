import Foundation

let startTime = NSDate()

let day7 = Day7()
day7.part1()
day7.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
