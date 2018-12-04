//
//  main.swift
//  L5_KazakovAleksei
//
//  Created by Алексей Казаков on 04/12/2018.
//  Copyright © 2018 Алексей Казаков. All rights reserved.
//

import Foundation

enum WindowStatus {
    case opened, closed
}

enum EngineStatus {
    case on, off
}

enum Brand {
    case Man
    case Mercedes
    case Mazda
}



protocol Carable {
    var yearOfManufactory: Int { get set }
    var brand: Brand { get set }
    var engineStatus: EngineStatus { get set }
    var windowStatus: WindowStatus { get set }
    // 1) Если добавлять сюда методы в таком виде: func windowAction (newStatus: WindowStatus) - при имплементации протокола требуется снова их реализовать (по какой то причине реализация по умолчанию не работает). Подскажите, с чем это может быть связано?
}

extension Carable { //реализую метод открытия/ закрытия окон
    mutating func windowAction (newStatus: WindowStatus) { // 2) Сможете рассказать, почему без mutating выдается ошибка? насколько сам понял, mutating означает, что этот метод может изменять свойство windowStatus. Или я ошибаюсь?
        switch newStatus {
        case .opened:
            windowStatus = .opened
        case .closed:
            windowStatus = .closed
        }
    }
}

extension Carable { //реализую метод запуска/ заглушения двигателя
    mutating func engineAction (newStatus: EngineStatus) {
        switch newStatus {
        case .on:
            engineStatus = .on
        case .off:
            engineStatus = .off
        }
    }
}

class SportCar: Carable { // 3) Подскажите, почему если имплементировать протокол через расширение выдается следующая ошибка: Extensions must not contain stored properties
    
    enum HatchStatus {
        case open, closed
    }
    
    var yearOfManufactory: Int
    var brand: Brand
    var engineStatus: EngineStatus {
        willSet {
            if newValue == .on{
                print("Заводим машину")
            } else {
                print("Глушим машину")
            }
        }
    }
    var windowStatus: WindowStatus{
        willSet {
            if newValue == .opened {
                print("Окна открываются")
            } else {
                print("Окна закрываются")
            }
        }
    }
    var hatchStatus: HatchStatus{
        willSet {
            if newValue == .open {
                print("Люк открывается")
            } else {
                print("Люк закрывается")
            }
        }
    }
    
    init (yearOfManufactory: Int, brand: Brand, engineStatus: EngineStatus, windowStatus: WindowStatus, hatchStatus: HatchStatus) {
        self.yearOfManufactory = yearOfManufactory
        self.brand = brand
        self.engineStatus = engineStatus
        self.windowStatus = windowStatus
        self.hatchStatus = hatchStatus
    }
}

extension SportCar { // добавляю в класс спорткар новый метод открытия/ закрытия люка
    func hatchAction (newStatus: HatchStatus){
        switch newStatus {
        case .open:
            hatchStatus = .open
        case .closed:
            hatchStatus = .closed
        }
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Дата выпуска: \(yearOfManufactory), бренд: \(brand), состояние двигателя: \(engineStatus), состояние окон: \(windowStatus), состояние люка: \(hatchStatus)"
    }
}

var car = SportCar(yearOfManufactory: 2018, brand: .Mazda, engineStatus: .off, windowStatus: .closed, hatchStatus: .closed)

car.engineAction(newStatus: .on)
car.windowAction(newStatus: .opened)
car.hatchAction(newStatus: .open)

print(car)

print("====================================================================")

class TrunkCar: Carable {
    enum TrailerStatus {
        case connected, disconnected
    }
    
    var yearOfManufactory: Int
    var brand: Brand
    var engineStatus: EngineStatus {
        willSet {
            if newValue == .on{
                print("Заводим машину")
            } else {
                print("Глушим машину")
            }
        }
    }
    var windowStatus: WindowStatus{
        willSet {
            if newValue == .opened {
                print("Окна открываются")
            } else {
                print("Окна закрываются")
            }
        }
    }
    
    var trailer: TrailerStatus {
        willSet {
            if newValue == .connected {
                print("Прицеп сейчас присоединится")
            } else {
                print("Отсоединяем прицеп")
            }
        }
    }
    
    init (yearOfManufactory: Int, brand: Brand, engineStatus: EngineStatus, windowStatus: WindowStatus, trailer: TrailerStatus){
        self.yearOfManufactory = yearOfManufactory
        self.brand = brand
        self.engineStatus = engineStatus
        self.windowStatus = windowStatus
        self.trailer = trailer
    }
    
    func trailerAction (newStatus: TrailerStatus) {
        switch newStatus{
        case .connected:
            self.trailer = .connected
        case .disconnected:
            self.trailer = .disconnected
        }
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Дата выпуска: \(yearOfManufactory), бренд: \(brand), состояние двигателя: \(engineStatus), состояние окон: \(windowStatus), состояние прицепа: \(trailer)"
    }
}

var trunk = TrunkCar(yearOfManufactory: 2000, brand: .Man, engineStatus: .on, windowStatus: .opened, trailer: .disconnected)

trunk.trailerAction(newStatus: .connected)
trunk.engineAction(newStatus: .off)
trunk.windowAction(newStatus: .closed)

print(trunk)
