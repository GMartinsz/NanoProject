//
//  popoverBehance.swift
//  NanoProject
//
//  Created by Daniel Leal on 30/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import Foundation
import UIKit


protocol Like:class {
    func liked()
}

protocol DownloadFinish: class {
    func finish()
}

class popoverPlexels: UIView {
    
    var urlAutor: URL?
    var urlOriginal: URL?
    var idImage = Int64()
    let function = Functions()
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var autor: UILabel!
    weak var delegate: Like?
    weak var delegate2: DownloadFinish?
  
    
    @IBAction func visitarAutor(_ sender: Any) {
        UIApplication.shared.open(urlAutor!)
    }
    
    @IBAction func baixarImagem(_ sender: Any) {
        self.delegate?.liked()
        function.downloadImage(url: urlOriginal!, idImage: idImage) { (imagem) in
            self.delegate2?.finish()
        }
    }
    
}
