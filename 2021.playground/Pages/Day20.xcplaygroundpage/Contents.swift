import Foundation

let startTime = NSDate()

let day20 = Day20()
day20.part1()
day20.part2()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print("Time (seconds): ", String(format:"%.3f", interval))
