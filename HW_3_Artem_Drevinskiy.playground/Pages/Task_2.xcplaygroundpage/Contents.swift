//: [Previous](@previous)

import Foundation

struct Compass {
    /// Все константы скорее относятся к типу, чем к значениям. Можно сделать `static`.
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
        turnAngle = 0
//        changeDirection(angle: turnAngle)
    }
    
    /// Почему у тебя в `CardinalPoints` используется угол от 0 до 360, а в компасе уже от -180 до 180?
    /// И главный вопрос, почему же создал ты такой красивый тип `CardinalPoints`,
    /// но не используешь его в данном задании?
    
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
    /// Подчет выше ^^ неплохо работает, но почему Север это ровно 0 градусов,
    /// а Северо-Восток это целый диапазон от 0 до 90? Как-то не равноценно мне кажется.
    /// Лучше было бы распределить равномерно.
    
    /// Не обязательно возвращать инфу для консоли из функции. Можно просто писать `print` внутри.
    mutating func turnClockwise(angle: Int) -> String {
        /// Здесь можно просто `if` вместо `guard`
        guard angle + turnAngle < 180 else {
            /// А если передать в функцию угол в 420 градусов? Такой трюк не сработает :)
            turnAngle = (-180) + (angle + turnAngle - 180)
            changeDirection(angle: turnAngle)
            return "Successful turn"
        }
        /// Лучше пиши проверки наоборот. Слева всегда то значение, которое сравниваешь с константой
        /// Например `angle >= 0` и `angle < 180`
        guard 180 > angle && angle > 0 else {
            /// Кажется этот `guard` должен идти первым.
            return "Wrong angle! Please enter angle from 0 to 180"
        }
        turnAngle += angle
        changeDirection(angle: turnAngle)
        return "Successful turn"

    }
    
    /// Все те же комменты, что и для функции выше.
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
        
    /// Кажется, что не хватает функции `turn(by angle: Int)`, внутри которой
    /// будешь вызывать одну из функций `turnClockwise` или `turnCounterClockwise`
}

func showCompassInfo(compass: Compass) {
    print("Compass direction: \(compass.direction)")
    print("Compass angle: \(compass.turnAngle)")

    /// Здесь нужно использовать параметр `compass` походу, а не `someCompass`
    someCompass.turnAngle
}

var someCompass = Compass(angle: 0)

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
