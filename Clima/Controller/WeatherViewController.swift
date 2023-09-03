//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
     var weatherManager = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }

    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
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

