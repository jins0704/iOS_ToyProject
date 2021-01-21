//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//
//e0feffd1cc82cc48108063bc96cfcd42
import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weathermanager = WeatherManager()
    let locationmanager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.requestLocation()
        
        weathermanager.delegate = self
        searchTextField.delegate = self
    }
}

//MARK : - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
          searchTextField.endEditing(true)//키보드 끄기
          //searchTextField.text
      }
      
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          searchTextField.endEditing(true)//키보드 끄기
          return true
      }
      
      func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
          //무엇인가 꼭 검색해야됨 아니면 안꺼짐
          if textField.text != ""{
              return true
          }else{
              textField.placeholder = "type something here"
              return false
          }
      }
      func textFieldDidEndEditing(_ textField: UITextField) {
          
          if let city = searchTextField.text{
              weathermanager.fetchWeather(cityName: city)
          }
          searchTextField.text = ""//검색창 비우기
      }
}

//MARK : - WeatherManagerDelegate

extension WeatherViewController : WeatherManagerDelegate{
    
    func didUpdateWeather(_ weathermanager : WeatherManager ,weather : WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK : - CLLocationManagerDelegate

extension WeatherViewController : CLLocationManagerDelegate {
    
    @IBAction func locationPressed(_ sender: UIButton) {
        print("got location")
        locationmanager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationmanager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weathermanager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
