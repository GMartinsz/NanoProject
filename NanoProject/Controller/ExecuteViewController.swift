//
//  ExecuteViewController.swift
//  NanoProject
//
//  Created by Guilherme Martins Dalosto de Oliveira on 29/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ExecuteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getText(from url: String, key: String, completion: @escaping (String) -> ()) {
        Alamofire.request(url, method: .get, parameters: [:], encoding: JSONEncoding.default, headers: ["Accept": "application/json"]).responseData { (responseData) in
            let json = JSON(responseData.result.value!)
            let dict = json.dictionaryObject
            let value = dict![key] as! String
            completion(value)
        }
    }
    
    
    
    
    
    
    
    

}
