//
//  CustomCellCollection.swift
//  NanoProject
//
//  Created by Daniel Leal on 31/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import Foundation
import UIKit

class CustomCellCollection: UICollectionViewCell {
    
    
    @IBOutlet weak var imagemCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    var categoria = String()
    var text = String()
    var autor = String()
    var titulo = String()
    
    
}
