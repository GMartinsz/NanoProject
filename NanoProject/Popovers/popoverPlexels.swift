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
    var urlOriginal: URL?
    var idImage = Int64()
    let function = Functions()
    @IBOutlet weak var curtirOutlet: UIButton!
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var autor: UILabel!
    weak var delegate: Like?
  
    
    @IBAction func visitarAutor(_ sender: Any) {
        UIApplication.shared.open(urlAutor!)
    }
    
    @IBAction func baixarImagem(_ sender: Any) {
        curtirOutlet.isEnabled = false
        self.delegate?.liked()
        function.saveImageCoreData(imagem: imagem.image!, idImage: idImage, entidade: "FavoriteImage", autor: autor.text!)
    }
    
}
