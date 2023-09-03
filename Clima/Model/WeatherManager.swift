//
//  WeatherManager.swift
//  Clima
//
//  Created by Guillaume Staub on 31/08/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://pro.openweathermap.org/data/2.5/weather?&units=metric&appid=796462b197e608786bb7e39f38e1e989"
    
    func fetchWeather(cityName:String){
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString:String)  {
        
        //TODO : 1 : Create a URL
        if let url = URL(string: urlString){
            
            //TODO : 2. Create a URLSession
            
            let session = URLSession(configuration: .default)
            //TODO : 3. Give the session tastk
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString!)
                }
            }
            //TODO : 4. Start the task
            task.resume()
        }
        
    }
    
    
}

