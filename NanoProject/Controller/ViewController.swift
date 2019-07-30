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
    @IBOutlet var popoverPlexels: popoverPlexels!
    
    @IBOutlet var labelOutlet: popoverLabel!
    
    var canButton = false
    let functions = Functions()

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOutlet.layer.cornerRadius = 30
        buttonOutlet.layer.borderWidth = 1
        
    }
    
    func aleatorio(){
       
            
    }
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBAction func generateButton(_ sender: UIButton) {
        
        self.getRandomImages()
//
//        canButton = !canButton
//        if canButton{
//            popoverImagem.removeFromSuperview()
//            labelOutlet.removeFromSuperview()
//            let index = Int.random(in: 0...4)
//            switch index {
//            case 0:
//                getJokes()
//                self.view.backgroundColor = .init(red: 1, green: 0.8, blue: 0.05, alpha: 1)
//            case 1:
//                getCNFacts()
//                self.view.backgroundColor = .init(red: 0.8, green: 0.2, blue: 0.2, alpha: 1)
//            case 2:
//                getQuotes()
//                self.view.backgroundColor = .init(red: 0.5, green: 0.52, blue: 0.6, alpha: 1)
//            case 3:
//                 newsPorPais()
//                self.view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
//            case 4:
//                getInsults()
//                self.view.backgroundColor = .init(red: 1, green: 0.2, blue: 0.2, alpha: 1)
//            case 5:
//                self.newsSports()
//            default:
//                getJokes()
//                self.view.backgroundColor = .init(red: 1, green: 0.8, blue: 0.05, alpha: 1)
//            }
//        }

        
    }
    
    
    
    func newsPorPais(){
        let apiNews = News()
        apiNews.country = "br"
        functions.searchTopHeadlines(api: apiNews, completion: { (imagem, artigo) in
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

        })
        
    }
    
    func newsSports(){
        let api = News()
        api.country = "br"
        functions.searchSports(api: api, completion: { (imagem, artigo) in
            print(artigo)
            guard let content = artigo["content"] else {return}
            guard let title = artigo["title"] else {return}
            guard let urlDestino = artigo["url"] else {return}
            self.popoverImagem.imagem.image = imagem
            if let conteudo = content as? String {
                self.popoverImagem.noticia.text =  conteudo
            }else {
                guard let description = artigo["description"] else {return}
                if let descricao = description as? String {
                    self.popoverImagem.noticia.text =  descricao
                }else {
                    self.popoverImagem.noticia.text =  ""
                }
            }
            self.view.addSubview(self.popoverImagem)
            self.popoverImagem.center = self.view.center
            self.popoverImagem.tituloNoticia.text = (title as! String)
            self.popoverImagem.url = URL(string: urlDestino as! String)
            self.canButton = !self.canButton
        })
        
    }
    
    func getRandomImages(){
        let api = Plexels()
        functions.getImages(api: api) { (imagem, photo) in
            self.view.addSubview(self.popoverPlexels)
            self.popoverPlexels.center = self.view.center
            self.popoverPlexels.imagem.image = imagem
            
            var autor = String()
            if let aut = photo["photographer"] as? String {
                autor = aut
            }else {
                autor = "Desconhecido"
            }
            self.popoverPlexels.autor.text = autor
            
            let urlString = photo["photographer_url"] as! String
            let urlAutor = URL(string: urlString)

            self.popoverPlexels.urlAutor = urlAutor!
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
    

}

