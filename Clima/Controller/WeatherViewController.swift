//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
class WeatherViewController: UIViewController {
   
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchTextField.delegate = self
        weatherManager.delegate = self
        
    }

    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    
    
}

//MARK: -UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        searchTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            //Si le champs est non vide on permet à l'utilisateur de faire disparaitre le clavier
            return true
        }else{
            //Si il est vide on lui indique un conseil supplémentaire
            textField.placeholder = "Taper le nom d'une ville"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
            
        }
        searchTextField.text = ""
        
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather:WeatherModel)  {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureRound
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
        
    }
    
    func didFailWithError(error: Error) {
        
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
}
