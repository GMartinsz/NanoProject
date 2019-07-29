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
    @IBOutlet var popoverNews: News!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(popoverFactsCN)
       
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func generateButton(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var textViewOutlet: UITextView!
    
    
    


}

