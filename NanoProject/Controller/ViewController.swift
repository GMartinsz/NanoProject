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
    
    @IBOutlet var imagePopover: UIImageView!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet var labelOutlet: popoverLabel!
    
    var canButton = false
    let functions = Functions()
    var ultimoPopover = UIView()
    var entrouFavPopover = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOutlet.layer.cornerRadius = 30
        buttonOutlet.layer.borderWidth = 1
        buttonOutlet.backgroundColor = .init(red: 0.9, green: 0.40, blue: 0.20, alpha: 1)
    }

    @IBAction func generateButton(_ sender: UIButton) {
        
        canButton = !canButton
        if canButton{
            imagePopover.removeFromSuperview()
            popoverImagem.removeFromSuperview()
            labelOutlet.removeFromSuperview()
            let index = Int.random(in: 0...8)
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
                newsPorPais()
                self.view.backgroundColor = .gray
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
            case 6:
                getMemes()
                self.view.backgroundColor = .init(red: 0, green: 0.8, blue: 0.2, alpha: 1)
                self.popoverImagem.backgroundColor = self.view.backgroundColor
                self.labelOutlet.backgroundColor = self.view.backgroundColor
            case 7:
                getRandomImages()
                //Mudar background
            case 8:
                newsSports()
                //Mudar background
            default:
                print("teste")
            }
        }
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
            self.newsOutletAutoLayout()
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
            
            guard let urlString = photo["photographer_url"] as? String else {return}
            guard let urlAutor = URL(string: urlString) else {return}
            guard let src = photo["src"] as? [String:AnyObject] else {return}
            guard let stringOriginal = src["portrait"] as? String else {return}
            guard let urlOriginal = URL(string: stringOriginal) else {return}
            guard let id = photo["id"] as? Int64 else {return}
            
            self.popoverPlexels.idImage = id
            self.popoverPlexels.urlAutor = urlAutor
            self.popoverPlexels.urlOriginal = urlOriginal
            self.popoverPlexels.delegate = self
            self.ultimoPopover = self.popoverPlexels
        }
    }
    


    func getJokes(){
        let jokes = Jokes()
        functions.getText(type: .simple, from: jokes.url, key: jokes.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.view.addSubview(self.labelOutlet)
            self.labelOutletAutoLayout()
            self.canButton = !self.canButton
        }
    }
    
    func getCNFacts(){
        let facts = FactsCN()
        functions.getText(type: .simple, from: facts.url, key: facts.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.view.addSubview(self.labelOutlet)
            self.labelOutletAutoLayout()
            self.canButton = !self.canButton
        }
    }
 
    
    func getQuotes(){
        let quotes = Quote()
        functions.getText(type: .quotes, from: quotes.url, key: quotes.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.view.addSubview(self.labelOutlet)
            self.labelOutletAutoLayout()
            self.canButton = !self.canButton
        }
    }
    
    func getInsults(){
        let insults = Insults()
        functions.getText(type: .simple, from: insults.url, key: insults.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.view.addSubview(self.labelOutlet)
            self.labelOutletAutoLayout()
            self.canButton = !self.canButton
        }
    }
    
    func getCatFacts(){
        let catFacts = CatFacts()
        functions.getText(type: .simple, from: catFacts.url, key: catFacts.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.view.addSubview(self.labelOutlet)
            self.labelOutletAutoLayout()
            self.canButton = !self.canButton
        }
    }
    
    func getMemes(){
        Alamofire.request("https://meme-api.herokuapp.com/gimme/memes").responseData { response in
            let data = JSON(response.result.value!)
            let dataDO = data.dictionaryObject
            let url = dataDO!["url"] as! String
            self.functions.baixarImagem(url: URL(string: url)!, completion: { (imagem) in
                self.imagePopover.image = imagem
                self.view.addSubview(self.imagePopover)
                self.imageOutletAutoLayout()
                self.canButton = !self.canButton
            })
        }
    }
    
    func labelOutletAutoLayout() {
        self.labelOutlet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.labelOutlet!, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.labelOutlet!, attribute: .centerY, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.labelOutlet!, attribute: .height, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.height, multiplier: 0.5, constant:0.0).isActive = true
        
        NSLayoutConstraint(item: self.labelOutlet!, attribute: .width, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.width, multiplier: 0.8, constant:0.0).isActive = true
    }
    
    func imageOutletAutoLayout() {
        self.imagePopover.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.imagePopover!, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.imagePopover!, attribute: .centerY, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.imagePopover!, attribute: .height, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.height, multiplier: 0.70, constant:0.0).isActive = true
        
        NSLayoutConstraint(item: self.imagePopover!, attribute: .width, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.width, multiplier: 0.8, constant:0.0).isActive = true
    }
    
    func newsOutletAutoLayout() {
        self.popoverImagem.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.popoverImagem!, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.popoverImagem!, attribute: .centerY, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.popoverImagem!, attribute: .height, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.height, multiplier: 0.70, constant:0.0).isActive = true
        
        NSLayoutConstraint(item: self.popoverImagem!, attribute: .width, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.width, multiplier: 0.8, constant:0.0).isActive = true
    }
    

}



//Delegates

extension ViewController: Like{
    func liked() {
        let alert = UIAlertController(title: "Favoritado", message: "Adicionado aos seus favoritos com sucesso!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

//Segues
extension ViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFav" {
            if let destino  = segue.destination as? ViewControllerFavs{
                self.popoverPlexels.delegate2 = destino as DownloadFinish
            }
        }
    }
}

