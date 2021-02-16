//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didFailWithError(_ coinmanager : CoinManager, error: Error)
    func didUpdateCoin(_ coinmanager : CoinManager, rate : Double, num : Int)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "apikey=???"
    
    var delegate : CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func performRequest(with urlString : String, num : Int){
        let Num = num
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(self, error: error!)
                        return
                }
                
                if let safeData = data{
                    if let rate = self.parseJSON(safeData){
                        self.delegate?.didUpdateCoin(self, rate : rate, num : Num)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data : Data) -> Double?{
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(CoinData.self, from : data)
            let lastPrice = decodeData.rate
            
            return lastPrice
        }catch{
            
            delegate?.didFailWithError(self, error:error)
            return nil
        }
    }
}
