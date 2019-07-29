//
//  popoverImage.swift
//  NanoProject
//
//  Created by Guilherme Martins Dalosto de Oliveira on 29/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import Foundation
import UIKit

class popoverImage : UIView {
    
    var url: URL?
    
    @IBOutlet weak var imagem: UIImageView!

    @IBOutlet weak var noticia: UITextView!
    
    @IBOutlet weak var tituloNoticia: UILabel!
    
    @IBAction func buttonVerMais(_ sender: Any) {
        UIApplication.shared.open(url!)
    }
    
}
