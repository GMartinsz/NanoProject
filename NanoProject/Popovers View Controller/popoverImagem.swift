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
    var entidade = String()
    var urlGif = String()
    var imagemData: Data?
    
    @IBOutlet weak var imagem: UIImageView!
    
    @IBAction func curtir(_ sender: Any) {
        
        var ultimoId = functions.buscarUltimoIdCoreData(entidade: entidade)
        curtirOutlet.isEnabled = false
        ultimoId += 1
        functions.saveImageCoreData(imagem: imagem.image!, idImage: ultimoId, entidade: entidade, autor: "", gifData: imagemData!)
        self.delegate?.liked()
        
    }
    
    
    
}
