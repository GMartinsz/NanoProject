//
//  ViewController.swift
//  NanoProject
//
//  Created by Guilherme Martins Dalosto de Oliveira on 25/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON



class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func generateButton(_ sender: UIButton) {
//        getText(from: "https://icanhazdadjoke.com/", key: "joke")
//        getText(from: "https://api.chucknorris.io/jokes/random", key: "value")
        getText(from: "https://icanhazdadjoke.com/", key: "joke") { (textValue) in
            self.textViewOutlet.text = textValue
        }

        
    }
    
    @IBOutlet weak var textViewOutlet: UITextView!
    
    
    


}

