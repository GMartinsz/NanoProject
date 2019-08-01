//
//  popoverImagemView2.swift
//  NanoProject
//
//  Created by Daniel Leal on 31/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import Foundation
import UIKit

class popoverImagem: UIView {
    
    let functions = Functions()
    @IBOutlet weak var curtirOutlet: UIButton!
    
    var urlImagem: URL?
    weak var delegate: Like?
    
    @IBOutlet weak var imagem: UIImageView!
    
    @IBAction func curtir(_ sender: Any) {
        curtirOutlet.isEnabled = false
        var ultimoId = functions.buscarUltimoIdCoreData(entidade: "MemesData")
        ultimoId += 1
        functions.saveImageCoreData(imagem: imagem.image!, idImage: ultimoId, entidade: "MemesData", autor: "")
        self.delegate?.liked()
        
    }
    
    
    
}
