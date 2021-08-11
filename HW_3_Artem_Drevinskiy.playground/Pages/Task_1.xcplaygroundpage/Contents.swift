import UIKit

// Task 1 Стороны света

/// Лучше в единственном числе назвать `CardinalPoint`
struct CardinalPoints {
    /// Все константы скорее относятся к типу, чем к значениям. Можно сделать `static`.
    let north = 0
    let northEast = 45
    let east = 90
    let southEast = 135
    let south = 180
    let southWest = 225
    let west = 270
    let northWest = 315
    
    var direction: String
    
    /// Лишний пробел перед открывающей скобкой ` (`
    /// Здесь так же хорошо подошел бы опциональный инициализатор `init?()`,
    /// т.к. не для любой строки можно создать свое направление
    init (direction: String) {
        self.direction = direction
    }
    
    /// Не уверен, что направлению нужен метод для смены значения.
    /// Кажется, что это нужно проверять в инициализаторе.
    mutating func setDirection(_ direction: String) {
        if direction.count > 2 {
            print("Wrong direction. Try again...")
        } else {
        /// Не хватает таба перед выражением `  `
        self.direction = direction
        }
    }
    
    /// Лишний пробел перед открывающей скобкой ` (`
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
    /// Функция для проверки - это хорошо, но почему сравнивается с 1 значением только?
    /// Здесь бы неплохо проверить на выход на предел значений `-180...180` или `0..<360`
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




