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


protocol Like:class {
    func liked()
}



class ViewController: UIViewController {
    
    
    //Popovers
    @IBOutlet var popoverNoticias: popoverNoticias!
    @IBOutlet weak var loadingOutlet: UIActivityIndicatorView!
    @IBOutlet var popoverPlexels: popoverPlexels!
    @IBOutlet var popoverImagens: popoverImagem!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet var labelOutlet: popoverLabel!
    @IBOutlet weak var titleOutlet: UILabel!
    
    var canButton = false
    let functions = Functions()
    var ultimoPopover = UIView()
    var entrouFavPopover = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        labelOutlet.delegate = self
        popoverImagens.delegate = self
        popoverNoticias.delegate = self
        popoverPlexels.delegate = self
        buttonOutlet.layer.cornerRadius = 25
        buttonOutlet.layer.borderWidth = 1
        buttonOutlet.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonOutlet.titleLabel?.minimumScaleFactor = 0.5
        buttonOutlet.backgroundColor = .init(red: 0.9, green: 0.40, blue: 0.20, alpha: 1)
        loadingOutlet.stopAnimating()
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    @IBAction func generateButton(_ sender: UIButton) {

        canButton = !canButton
        if canButton{
            loadingOutlet.startAnimating()
            popoverPlexels.removeFromSuperview()
            popoverNoticias.removeFromSuperview()
            popoverImagens.removeFromSuperview()
            labelOutlet.removeFromSuperview()
            popoverPlexels.curtirOutlet.isEnabled = true
            popoverNoticias.curtirOutlet.isEnabled = true
            popoverImagens.curtirOutlet.isEnabled = true
            labelOutlet.curtirOutlet.isEnabled = true
            let index = Int.random(in: 0...11)
            switch index {
            case 0:
                getJokes()
                self.view.backgroundColor = .init(red: 1, green: 0.8, blue: 0.05, alpha: 1)
                self.titleOutlet.text = "Jokes"
            case 1:
                getCNFacts()
                self.view.backgroundColor = .init(red: 0.8, green: 0.2, blue: 0.2, alpha: 1)
                self.titleOutlet.text = "Chuck Norris Facts"
            case 2:
                getQuotes()
                self.view.backgroundColor = .init(red: 0.5, green: 0.52, blue: 0.6, alpha: 1)
                self.titleOutlet.text = "Quotes"
            case 3:
                newsPorPais()
                self.view.backgroundColor = .gray
                self.titleOutlet.text = "News"
            case 4:
                getInsults()
                self.view.backgroundColor = .init(red: 1, green: 0.2, blue: 0.2, alpha: 1)
                self.titleOutlet.text = "Insults"
            case 5:
                getCatFacts()
                self.view.backgroundColor = .init(red: 1, green: 0.8, blue: 0.05, alpha: 1)
                self.titleOutlet.text = "Cat Facts"
            case 6:
                getMemes()
                self.view.backgroundColor = .init(red: 0, green: 0.8, blue: 0.2, alpha: 1)
                self.titleOutlet.text = "Memes"
            case 7:
                getRandomImages()
                self.titleOutlet.text = "Images"
            case 8:
                newsSports()
                self.titleOutlet.text = "Sport News"
            case 9:
                getGifs()
                self.titleOutlet.text = "Gifs"
            case 10:
                getMovie()
                self.titleOutlet.text = "Movie Recommendation"
            case 11:
                getTVShow()
                self.titleOutlet.text = "TV Show Recommendation"
          default:
                print("teste")
            }
        }

    }
    
    
    
    func newsPorPais(){
        let apiNews = News()
        apiNews.country = "br"
        functions.searchTopHeadlines(api: apiNews, completion: { (imagem, artigo) in
            guard let content = artigo["content"] else {return}
            guard let title = artigo["title"] else {return}
            guard let urlDestino = artigo["url"] else {return}
            guard let source = artigo["source"] as? [String: AnyObject] else {return}
            var fontName = String()
            if let nameSource = source["name"] as? String {
                fontName = nameSource
            }else if let idSource = source["id"] as? String {
                fontName = idSource
            }
            self.popoverNoticias.autorNoticia = fontName
            self.popoverNoticias.imagem.image = imagem
            self.popoverNoticias.noticia.text =  (content as! String)
            self.view.addSubview(self.popoverNoticias)
            self.popoverNoticias.center = self.view.center
            self.newsOutletAutoLayout()
            self.popoverNoticias.tituloNoticia.text = (title as! String)
            self.popoverNoticias.url = URL(string: urlDestino as! String)
            self.canButton = !self.canButton
            self.loadingOutlet.stopAnimating()
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
            guard let source = artigo["source"] as? [String: AnyObject] else {return}
            var fontName = String()
            if let nameSource = source["name"] as? String {
                fontName = nameSource
            }else if let idSource = source["id"] as? String {
                fontName = idSource
            }
            self.popoverNoticias.autorNoticia = fontName
            self.popoverNoticias.imagem.image = imagem
            if let conteudo = content as? String {
                self.popoverNoticias.noticia.text =  conteudo
            }else {
                guard let description = artigo["description"] else {return}
                if let descricao = description as? String {
                    self.popoverNoticias.noticia.text =  descricao
                }else {
                    self.popoverNoticias.noticia.text =  ""
                }
            }

            self.view.addSubview(self.popoverNoticias)
            self.newsOutletAutoLayout()
            self.popoverNoticias.tituloNoticia.text = (title as! String)
            self.popoverNoticias.url = URL(string: urlDestino as! String)
            self.canButton = !self.canButton
            self.loadingOutlet.stopAnimating()
        })
        
    }
    
    func getRandomImages(){
        let api = Plexels()
        functions.getImages(api: api) { (imagem, photo) in
            self.view.addSubview(self.popoverPlexels)
            self.plexelsOutletAutoLayout()
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
            self.ultimoPopover = self.popoverPlexels
            self.canButton = !self.canButton
            self.loadingOutlet.stopAnimating()
        }
    }
    


    func getJokes(){
        let jokes = Jokes()
        functions.getText(type: .simple, from: jokes.url, key: jokes.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.labelOutlet.entidade = "JokesData"
            self.view.addSubview(self.labelOutlet)
            self.labelOutletAutoLayout()
            self.canButton = !self.canButton
            self.loadingOutlet.stopAnimating()
        }
    }
    
    func getCNFacts(){
        let facts = FactsCN()
        functions.getText(type: .simple, from: facts.url, key: facts.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.labelOutlet.entidade = "FactsCNData"
            self.view.addSubview(self.labelOutlet)
            self.labelOutletAutoLayout()
            self.canButton = !self.canButton
            self.loadingOutlet.stopAnimating()
        }
    }
 
    
    func getQuotes(){
        let quotes = Quote()
        functions.getText(type: .quotes, from: quotes.url, key: quotes.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.labelOutlet.entidade = "QuoteData"
            self.view.addSubview(self.labelOutlet)
            self.labelOutletAutoLayout()
            self.canButton = !self.canButton
            self.loadingOutlet.stopAnimating()
        }
    }
    
    func getInsults(){
        let insults = Insults()
        functions.getText(type: .simple, from: insults.url, key: insults.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.labelOutlet.entidade = "InsultoData"
            self.view.addSubview(self.labelOutlet)
            self.labelOutletAutoLayout()
            self.canButton = !self.canButton
            self.loadingOutlet.stopAnimating()
        }
    }
    
    func getCatFacts(){
        let catFacts = CatFacts()
        functions.getText(type: .simple, from: catFacts.url, key: catFacts.key) { (value) in
            self.labelOutlet.textLabel.text = value
            self.labelOutlet.entidade = "CatFactsData"
            self.view.addSubview(self.labelOutlet)
            self.labelOutletAutoLayout()
            self.canButton = !self.canButton
            self.loadingOutlet.stopAnimating()
        }
    }
    
    func getMemes(){
        Alamofire.request("https://meme-api.herokuapp.com/gimme/memes").responseData { response in
            let data = JSON(response.result.value!)
            let dataDO = data.dictionaryObject
            let url = dataDO!["url"] as! String
            self.functions.baixarImagem(url: URL(string: url)!, completion: { (imagem) in
                self.popoverImagens.imagem.image = imagem
                self.view.addSubview(self.popoverImagens)
                self.imageOutletAutoLayout()
                self.canButton = !self.canButton
                self.loadingOutlet.stopAnimating()
            })
        }
    }
    
    func getGifs(){
        Alamofire.request("https://api.giphy.com/v1/gifs/random?&api_key=UgDD2ElfL0K0kCJHIUuG5k6PDsRZldqM&rating=g&tag=funny").responseData { (responseData) in
            let value = JSON(responseData.result.value!).dictionaryObject
            let array = value!["data"] as! [String: AnyObject]
            let url = array["image_url"] as! String
            let image = UIImage.gifImageWithURL(url)
            self.popoverImagens.imagem.image = image
            self.view.addSubview(self.popoverImagens)
            self.imageOutletAutoLayout()
            self.canButton = !self.canButton
            self.loadingOutlet.stopAnimating()
        }
    }
    
    func getShow(type: String, titleKey: String) {
        let page = Int.random(in: 1...10)
        Alamofire.request("https://api.themoviedb.org/3/discover/" + type + "?api_key=0a5245c38a864d2cc499008bcd045b6f&language=pt-BR&page=\(page)").responseData { (responseData) in
            var array: [[String: String]] = []
            let data = JSON(responseData.result.value!).dictionaryObject
            let movies = data!["results"] as! [[String: AnyObject]]
            for movie in movies {
                if movie["original_language"]! as! String != "ja", movie["overview"]! as! String != ""{
                    var dict = [String: String]()
                    dict["title"] = movie[titleKey] as? String
                    dict["urlImage"] = movie["poster_path"] as? String
                    dict["descricao"] = movie["overview"] as? String
                    array.append(dict)
                }
            }
            let randomMovieIndex = Int.random(in: 0...array.count - 1)
            let chosenMovie = array[randomMovieIndex]
            self.functions.baixarImagem(url: URL(string: "https://image.tmdb.org/t/p/w500/" + chosenMovie["urlImage"]!)!, completion: { (imagem) in
                self.popoverNoticias.imagem.image = imagem
                self.popoverNoticias.noticia.text = chosenMovie["descricao"]
                self.view.addSubview(self.popoverNoticias)
                self.newsOutletAutoLayout()
                self.popoverNoticias.tituloNoticia.text = chosenMovie["title"]
                self.canButton = !self.canButton
                self.loadingOutlet.stopAnimating()
            })
        }
    }
    
    func getMovie(){
        getShow(type: "movie", titleKey: "title")
    }
    
    func getTVShow(){
        getShow(type: "tv", titleKey: "name")
    }
    
    func labelOutletAutoLayout() {
        self.labelOutlet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.labelOutlet!, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.labelOutlet!, attribute: .centerY, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.labelOutlet!, attribute: .height, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.height, multiplier: 0.5, constant:0.0).isActive = true
        
        NSLayoutConstraint(item: self.labelOutlet!, attribute: .width, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.width, multiplier: 0.8, constant:0.0).isActive = true
    }
    
    func imageOutletAutoLayout() {
        self.popoverImagens.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.popoverImagens!, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.popoverImagens!, attribute: .centerY, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.popoverImagens!, attribute: .height, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.height, multiplier: 0.70, constant:0.0).isActive = true
        
        NSLayoutConstraint(item: self.popoverImagens!, attribute: .width, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.width, multiplier: 0.8, constant:0.0).isActive = true
    }
    
    func newsOutletAutoLayout() {
        self.popoverNoticias.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.popoverNoticias!, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.popoverNoticias!, attribute: .centerY, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.popoverNoticias!, attribute: .height, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.height, multiplier: 0.70, constant:0.0).isActive = true
        
        NSLayoutConstraint(item: self.popoverNoticias!, attribute: .width, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.width, multiplier: 0.8, constant:0.0).isActive = true
    }
    
    func plexelsOutletAutoLayout() {
        self.popoverPlexels.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.popoverPlexels!, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.popoverPlexels!, attribute: .centerY, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: self.popoverPlexels!, attribute: .height, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.height, multiplier: 0.70, constant:0.0).isActive = true
        
        NSLayoutConstraint(item: self.popoverPlexels!, attribute: .width, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute:.width, multiplier: 0.8, constant:0.0).isActive = true
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

