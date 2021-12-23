import Foundation

let startTime = NSDate()

PlayGround.run()

let endTime = NSDate()
let interval = endTime.timeIntervalSince(startTime as Date)

print(interval)
