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
    
    let functions = Functions()
    let jokes = Jokes()

    @IBOutlet var labelOutlet: popoverLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func generateButton(_ sender: UIButton) {
    
        functions.getText(type: .simple, from: jokes.url, key: jokes.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.view.addSubview(self.labelOutlet)
            self.labelOutlet.center = self.view.center
        }
        
    }
    
    @IBOutlet weak var textViewOutlet: UITextView!
    
    
    


}

