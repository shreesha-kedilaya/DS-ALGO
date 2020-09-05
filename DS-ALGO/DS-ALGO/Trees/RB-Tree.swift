//
//  RB-Tree.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 26/02/20.
//  Copyright © 2020 Shreesha Kedlaya. All rights reserved.
//

import Foundation

protocol CarFactoryProtocol {
    associatedtype CarType
    func produce() -> CarType
}
struct ElectricCar {
    let brand: String
}
struct PetrolCar {
    let brand: String
}

struct TeslaFactory: CarFactoryProtocol {
    typealias CarType = ElectricCar
    func produce() -> TeslaFactory.CarType {
        print("producing tesla electric car ...")
        return ElectricCar(brand: "Tesla")
    }
}

func implement() {

    let teslaFactory = TeslaFactory()
    teslaFactory.produce()

    struct BMWFactory: CarFactoryProtocol {
        typealias CarType = ElectricCar
    func produce() -> BMWFactory.CarType {
            print("producing bmw electric car ...")
            return ElectricCar(brand: "BMW")
        }
    }
    struct ToyotaFactory: CarFactoryProtocol {
        typealias CarType = PetrolCar
    func produce() -> ToyotaFactory.CarType {
            print("producing toyota petrol car ...")
            return PetrolCar(brand: "Toyota")
        }
    }
    let bmwFactory = BMWFactory()
    bmwFactory.produce()
    let toyotaFactory = ToyotaFactory()
    toyotaFactory.produce()
}
