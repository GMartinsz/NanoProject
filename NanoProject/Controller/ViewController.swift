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
    }
    
    @IBAction func generateButton(_ sender: UIButton) {
        
//        let numAleatorio = randomContent(limite: 3)
        conteudoNews()
//        functions.getText(type: .simple, from: jokes.url, key: jokes.key) { (value) in
//            self.labelOutlet.textLabel.text = value
//            self.view.addSubview(self.labelOutlet)
//            self.labelOutlet.center = self.view.center
//        }
        
       
        
    }
    
    func conteudoNews(){
        let apiNews = News()
        apiNews.country = "br"
        guard let apiTopHead = apiNews.topHeadLinesUrl else {return}
        functions.searchTopHeadlines(topHeadLinesUrl: apiTopHead, pais: apiNews.country, apiKey: apiNews.apiKey) { (imagem, artigo) in
            guard let content = artigo["description"] else {return}
            guard let title = artigo["title"] else {return}
            guard let urlDestino = artigo["url"] else {return}
            self.popoverImagem.imagem.image = imagem
            self.popoverImagem.noticia.text =  (content as! String)
            self.view.addSubview(self.popoverImagem)
            self.popoverImagem.center = self.view.center
            self.popoverImagem.tituloNoticia.text = (title as! String)
            self.popoverImagem.url = URL(string: urlDestino as! String)

        }
        
    }
    
    
    func randomContent(limite: Int) -> Int{
        var index = Int()
        index = Int.random(in: 0...limite)
        return index
    }
    
    

}

