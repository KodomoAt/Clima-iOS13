//
//  WeatherManager.swift
//  Clima
//
//  Created by Guillaume Staub on 31/08/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
    let weatherURL = "https://pro.openweathermap.org/data/2.5/weather?&units=metric&appid="
   
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName:String){
    
        let urlString = "\(weatherURL)&q=\(cityName)"
        self.performRequest(with:urlString)
    }
    
    func fetchWeather(latitude:CLLocationDegrees, longitude: CLLocationDegrees){
    
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        self.performRequest(with:urlString)
    }
    func performRequest(with urlString:String)  {
        print(urlString)
        //TODO : 1 : Create a URL
        if let url = URL(string: urlString){
            
            //TODO : 2. Create a URLSession
            
            let session = URLSession(configuration: .default)
            //TODO : 3. Give the session tastk
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
              
                if let safeData = data{
                    if let weather =  self.parseJSON(safeData){
                        delegate?.didUpdateWeather(self, weather:weather)
                    }
                }
            }
            //TODO : 4. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData:Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
           let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
            
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}

