import UIKit

// Task 1 Стороны света

struct CardinalPoints {
    let north = 0
    let northEast = 45
    let east = 90
    let southEast = 135
    let south = 180
    let southWest = 225
    let west = 270
    let northWest = 315
    var direction: String
    
    init (direction: String) {
        self.direction = direction
    }
    
    mutating func setDirection(_ direction: String) {
        if direction.count > 2 {
            print("Wrong direction. Try again...")
        } else {
        self.direction = direction
        }
    }
    
    func showAzimuth () -> Int {
        if direction == "N" {
            return north
        } else if direction == "E" {
            return east
        } else if direction == "S" {
            return south
        } else if direction == "W" {
            return west
        } else if direction == "NE" {
            return northEast
        } else if direction == "SE" {
            return southEast
        } else if direction == "NW" {
            return northWest
        } else if direction == "SW" {
            return southWest
        } else {
            return 404
        }
    }
}

func checkAzimuth(azimuth: Int) {
    if azimuth == 404 {
        print ("Error. Direction not found")
    } else {
        print("Current azimuth: \(direction.showAzimuth())")
    }
}

var direction = CardinalPoints(direction: "e")

checkAzimuth(azimuth: direction.showAzimuth())
direction.setDirection("N")

checkAzimuth(azimuth: direction.showAzimuth())
direction.setDirection("wer")

checkAzimuth(azimuth: direction.showAzimuth())
direction.setDirection("s")

checkAzimuth(azimuth: direction.showAzimuth())
direction.setDirection("NW")
checkAzimuth(azimuth: direction.showAzimuth())




