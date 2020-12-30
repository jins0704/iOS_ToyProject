//
//  WeatherManager.swift
//  Clima
//
//  Created by 홍진석 on 2020/08/10.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weathermanager : WeatherManager ,weather : WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=e0feffd1cc82cc48108063bc96cfcd42&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName :String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with : urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        //create url
        if let url = URL(string: urlString){
            //create urlsession
            let session = URLSession(configuration: .default)
            
            //give the session a task
            let task = session.dataTask(with: url) { (data, respose, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather : weather)
                    }
                }
            }
            //start task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData : Data)->WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
