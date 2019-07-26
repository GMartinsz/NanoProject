//
//  apisMarcelo.swift
//  NanoProject
//
//  Created by Marcelo Henrique de Sousa Carvalho on 26/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension ViewController {
    
    func getChuckQuote() {
        Alamofire.request("https://api.chucknorris.io/jokes/random").responseData { (responseData) in
            let json = JSON(responseData.result.value!)
            let dict = json.dictionaryObject
            let value = dict!["value"] as! String
            print(value)
        }
    }
    
    func getDadJoke() {
        Alamofire.request("https://icanhazdadjoke.com/", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: ["Accept": "application/json"]).responseData { (responseData) in
            let json = JSON(responseData.result.value!)
            let dict = json.dictionaryObject
            let value = dict!["joke"] as! String
            print(value)
        }
    }
}
