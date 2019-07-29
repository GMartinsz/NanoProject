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
    
    func getText(from url: String, key: String, completion: @escaping (String) -> ()) {
        Alamofire.request(url, method: .get, parameters: [:], encoding: JSONEncoding.default, headers: ["Accept": "application/json"]).responseData { (responseData) in
            let json = JSON(responseData.result.value!)
            let dict = json.dictionaryObject
            let value = dict![key] as! String
            completion(value)
        }
    }
    
}
