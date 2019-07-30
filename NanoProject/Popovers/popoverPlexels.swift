//
//  popoverBehance.swift
//  NanoProject
//
//  Created by Daniel Leal on 30/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import Foundation
import UIKit

class popoverPlexels: UIView {
    
    var urlAutor: URL?
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var autor: UILabel!
  
    
    @IBAction func visitarAutor(_ sender: Any) {
        UIApplication.shared.open(urlAutor!)
    }
    
    @IBAction func baixarImagem(_ sender: Any) {
    }
    
}
