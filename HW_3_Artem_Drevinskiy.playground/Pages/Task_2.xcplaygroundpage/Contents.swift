//: [Previous](@previous)

import Foundation

struct Compass {
    let north = "N"        //0
    let northEast = "NE"   //45
    let east = "E"         //90
    let southEast = "SE"   //135
    let south = "S"        //180
    let southWest = "SW"   //-135
    let west = "W"         //-90
    let northWest = "NW"   //-45
    var direction: String = "N"
    var turnAngle: Int
    
    init(angle: Int) {
        turnAngle = angle
        changeDirection(angle: turnAngle)
    }
    
    mutating func changeDirection(angle: Int) {
        if angle == 0 {
            direction = north
        } else if 90 > angle && angle > 0 {
            direction = northEast
        } else if angle == 90 {
            direction = east
        } else if 180 > angle && angle > 90 {
            direction = southEast
        } else if angle == 180 || angle == -180 {
            direction = south
        } else if -90 < angle && angle < 0 {
            direction = northWest
        } else if angle == -90 {
            direction = west
        } else if -180 < angle && angle < -90 {
            direction = southWest
        }
    }
    mutating func turnClockwise(angle: Int) -> String {
        guard angle + turnAngle < 180 else {
            turnAngle = (-180) + (angle + turnAngle - 180)
            changeDirection(angle: turnAngle)
            return "Successful turn"
        }
        guard 180 > angle && angle > 0 else {
            return "Wrong angle! Please enter angle from 0 to 180"
        }
        turnAngle += angle
        changeDirection(angle: turnAngle)
        return "Successful turn"

    }
    mutating func turnCounterClockwise(angle: Int) -> String {
        guard turnAngle - angle > -180 else {
            turnAngle = 180 + (turnAngle - angle + 180)
            changeDirection(angle: turnAngle)
            return "Successful turn"
        }
        guard 180 > angle && angle > 0 else {
            return "Wrong angle! Please enter angle from 0 to 180"
        }
        turnAngle -= angle
        changeDirection(angle: turnAngle)
        return "Successful turn"
        
    }
    
}
func showCompassInfo(compass: Compass) {
    print("Compass direction: \(compass.direction)")
    print("Compass angle: \(compass.turnAngle)")

    someCompass.turnAngle
}
var someCompass = Compass(angle: 170)
showCompassInfo(compass: someCompass)
print(someCompass.turnClockwise(angle: 11))
showCompassInfo(compass: someCompass)
print(someCompass.turnClockwise(angle: 100))
showCompassInfo(compass: someCompass)
print(someCompass.turnCounterClockwise(angle: 111))
showCompassInfo(compass: someCompass)
print(someCompass.turnCounterClockwise(angle: 100))
showCompassInfo(compass: someCompass)
print(someCompass.turnCounterClockwise(angle: 120))
showCompassInfo(compass: someCompass)




//: [Next](@next)
