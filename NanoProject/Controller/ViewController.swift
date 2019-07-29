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
    
    
   
    
    
    @IBOutlet var popoverFactsCN: FactsCN!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(popoverFactsCN)
        news.searchTopHeadlines()
   
        quote.getData { (value) in
            print(value)
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func generateButton(_ sender: UIButton) {
        let index = Int.random(in: 0...urls.count - 1)
        getText(from: urls[index], key: keys[index]) { (textValue) in
            self.textViewOutlet.text = textValue
        }

        
    }
    
    @IBOutlet weak var textViewOutlet: UITextView!
    
    
    


}

