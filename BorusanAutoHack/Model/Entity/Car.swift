//
//  Car.swift
//  BorusanAutoHack
//
//  Created by Mac on 13.12.2023.
//

import Foundation

class Car {
    let brand: String
    let model: String
    let year: String
    let road: String
    let image: String
    let xg: Float
    let yg: Float
    let zg: Float
    
    init(brand: String, model: String, year: String, road: String, image: String, xg: Float, yg: Float, zg: Float) {
        self.brand = brand
        self.model = model
        self.year = year
        self.road = road
        self.image = image
        self.xg = xg
        self.yg = yg
        self.zg = zg
    }
}
