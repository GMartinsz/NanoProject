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
    @IBOutlet var labelOutlet: popoverLabel!
    
    var canButton = false
    let functions = Functions()

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOutlet.layer.cornerRadius = 30
        buttonOutlet.layer.borderWidth = 1
        buttonOutlet.backgroundColor = .init(red: 0.9, green: 0.40, blue: 0.20, alpha: 1)
        
    }
    
    func aleatorio(){
       
            
    }
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBAction func generateButton(_ sender: UIButton) {
        

        canButton = !canButton
        if canButton{
            popoverImagem.removeFromSuperview()
            labelOutlet.removeFromSuperview()
            let index = Int.random(in: 0...5)
            switch index {
            case 0:
                getJokes()
                self.view.backgroundColor = .init(red: 1, green: 0.8, blue: 0.05, alpha: 1)
                self.popoverImagem.backgroundColor = self.view.backgroundColor
                self.labelOutlet.backgroundColor = self.view.backgroundColor
            case 1:
                getCNFacts()
                self.view.backgroundColor = .init(red: 0.8, green: 0.2, blue: 0.2, alpha: 1)
                self.popoverImagem.backgroundColor = self.view.backgroundColor
                self.labelOutlet.backgroundColor = self.view.backgroundColor
            case 2:
                getQuotes()
                self.view.backgroundColor = .init(red: 0.5, green: 0.52, blue: 0.6, alpha: 1)
                self.popoverImagem.backgroundColor = self.view.backgroundColor
                self.labelOutlet.backgroundColor = self.view.backgroundColor
            case 3:
                conteudoNews()
                self.view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
                self.popoverImagem.backgroundColor = self.view.backgroundColor
                self.labelOutlet.backgroundColor = self.view.backgroundColor
            case 4:
                getInsults()
                self.view.backgroundColor = .init(red: 1, green: 0.2, blue: 0.2, alpha: 1)
                self.popoverImagem.backgroundColor = self.view.backgroundColor
                self.labelOutlet.backgroundColor = self.view.backgroundColor
            case 5:
                getCatFacts()
                self.view.backgroundColor = .init(red: 1, green: 0.8, blue: 0.05, alpha: 1)
                self.popoverImagem.backgroundColor = self.view.backgroundColor
                self.labelOutlet.backgroundColor = self.view.backgroundColor
            default:
                getCatFacts()
                self.view.backgroundColor = .init(red: 1, green: 0.8, blue: 0.05, alpha: 1)
                self.popoverImagem.backgroundColor = self.view.backgroundColor
                self.labelOutlet.backgroundColor = self.view.backgroundColor
            }
        }

        
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
            self.canButton = !self.canButton

        }
        
    }
    


    func getJokes(){
        let jokes = Jokes()
        functions.getText(type: .simple, from: jokes.url, key: jokes.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.view.addSubview(self.labelOutlet)
            self.labelOutlet.center = self.view.center
            self.canButton = !self.canButton
        }
    }
    
    func getCNFacts(){
        let facts = FactsCN()
        functions.getText(type: .simple, from: facts.url, key: facts.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.view.addSubview(self.labelOutlet)
            self.labelOutlet.center = self.view.center
            self.canButton = !self.canButton
        }
    }
 
    
    func getQuotes(){
        let quotes = Quote()
        functions.getText(type: .quotes, from: quotes.url, key: quotes.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.view.addSubview(self.labelOutlet)
            self.labelOutlet.center = self.view.center
            self.canButton = !self.canButton
        }
    }
    
    func getInsults(){
        let insults = Insults()
        functions.getText(type: .simple, from: insults.url, key: insults.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.view.addSubview(self.labelOutlet)
            self.labelOutlet.center = self.view.center
            self.canButton = !self.canButton
        }
    }
    
    func getCatFacts(){
        let catFacts = CatFacts()
        functions.getText(type: .simple, from: catFacts.url, key: catFacts.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.view.addSubview(self.labelOutlet)
            self.labelOutlet.center = self.view.center
            self.canButton = !self.canButton
        }
    }

}

