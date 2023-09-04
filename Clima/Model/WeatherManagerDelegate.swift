//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Guillaume Staub on 03/09/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather:WeatherModel)
    func didFailWithError(error:Error)
}
