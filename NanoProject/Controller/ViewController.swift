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

    @IBOutlet var popoverImagem: popoverImage!
    let functions = Functions()
    let jokes = Jokes()
    @IBOutlet var labelOutlet: popoverLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOutlet.layer.cornerRadius = 30
        buttonOutlet.layer.borderWidth = 1
        
    }
    
    func aleatorio(){
       
            
    }
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBAction func generateButton(_ sender: UIButton) {
        
        
        //conteudoNews()
      
        
       
        
    }
    
    
    
    func conteudoNews(){
        let apiNews = News()
        apiNews.country = "br"
        guard let apiTopHead = apiNews.topHeadLinesUrl else {return}
        functions.searchTopHeadlines(topHeadLinesUrl: apiTopHead, pais: apiNews.country, apiKey: apiNews.apiKey) { (imagem, artigo) in
            guard let content = artigo["description"] else {return}
            guard let title = artigo["title"] else {return}
            self.popoverImagem.imagem.image = imagem
            self.popoverImagem.noticia.text =  (content as! String)
            self.view.addSubview(self.popoverImagem)
            self.popoverImagem.center = self.view.center
            self.popoverImagem.tituloNoticia.text = (title as! String)

        }
        
    }
    

    
    

}

