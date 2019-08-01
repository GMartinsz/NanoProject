//
//  popoverLabel.swift
//  NanoProject
//
//  Created by Guilherme Martins Dalosto de Oliveira on 29/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import UIKit

class popoverLabel : UIView {
    
    @IBOutlet weak var textLabel: UILabel!
    var entidade = String()
    weak var delegate: Like?
    let functions = Functions()
    

    @IBAction func curtir(_ sender: Any) {
        
        var ultimoId = functions.buscarUltimoIdCoreData(entidade: entidade)
        ultimoId += 1
        functions.saveTextCoreData(texto: textLabel.text!, id: ultimoId, entidade: entidade)
        delegate?.liked()
    }
    
}
