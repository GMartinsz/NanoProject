//
//  Quote.swift
//  NanoProject
//
//  Created by Guilherme Martins Dalosto de Oliveira on 26/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import Alamofire
import SwiftyJSON

class Quote {
    
    let url = "https://favqs.com/api/qotd"
    
    func getData( completion: @escaping (String) -> ()){
        
        Alamofire.request(url, method: .get, parameters: [:], encoding: JSONEncoding.default, headers: ["Accept" : "application/json]"]).responseJSON { (responseData) in
            
        
            let jsonData = JSON(responseData.result.value!)
            let DOjsonData = jsonData.dictionaryObject
            print(DOjsonData)
            
            //completion(DOjsonData[""])

        
        
        
            
            
        }
        
        
    }
        
        
    
    
    
    func retrieveData(){
        getData { (value) in
            print(value)
        }
    }
    
  
    
    
}
