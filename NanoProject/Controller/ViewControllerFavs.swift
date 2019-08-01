//
//  ViewControllerFavs.swift
//  NanoProject
//
//  Created by Daniel Leal on 31/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct Imagens {
    var imagem = UIImage()
    var id = Int64()
    var autor = String()
}

struct Noticias {
    var imagem = UIImage()
    var texto = String()
    var id = Int64()
    var titulo = String()
    var fonte = String()
}

struct Frases {
    var frase = String()
    var id = Int64()
}

class ViewControllerFavs: UICollectionViewController {
    
    //Collections

    
    
    //Popovers
    @IBOutlet var popoverLabel: PopoverLabelCollection!
    @IBOutlet var popoverPlexels: PopoverPlexelCollection!
    @IBOutlet var popoverImagem: PopoverImagemCollection!
    @IBOutlet var popoverNoticias: PopoverNoticiasCollection!
    
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    private let itemsPerRow:CGFloat = 3
    
    //Arrays
    var arrayImagens = [Imagens]()
    var frasesChuckNorris = [Frases]()
    var arrayMemes = [Imagens]()
    var arrayNews = [Noticias]()
    var arrayGifs = [Imagens]()
    var arraySports = [Noticias]()
    var arrayFilmes = [Noticias]()
    var arrayFactsCN = [Frases]()
    var arrayQuotes = [Frases]()
    var arrayJokes = [Frases]()
    var arrayInsultos = [Frases]()
    var arrayCatFacts = [Frases]()
    var arraySections = [String]()
    
    var dictionaryArray = [String:AnyObject]()
    
    
    //Variaveis normais
    var blurEffectView = UIVisualEffectView()
    var entrouPopover = false
    
    override func viewWillAppear(_ animated: Bool) {
        setarConteudo()
    }
    
    deinit {
        print("saiu favoritos")
    }
    
    @IBAction func voltarButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if entrouPopover {
            entrouPopover = false
            self.blurEffectView.removeFromSuperview()
            self.removeAllPopovers()
        }
    }
    
}

extension ViewControllerFavs{
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reuseSection", for: indexPath) as! CustomSection
        
        if arraySections.count > 0 {
             section.titleSection.text = arraySections[indexPath.section]
        }

        return section
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let string = arraySections[section]
        
        if string == "Imagens" || string == "Memes" || string == "Gifs"{
            let array = dictionaryArray[string] as! [Imagens]
            return array.count
        }
        
        if string == "Notícias" || string == "Esportes" || string == "Filmes e Seriados"{
            let array = dictionaryArray[string] as! [Noticias]
            return array.count
        }
        
        if string == "Piadas" || string == "Fatos de Gatos" || string == "Fatos Chuck Norris" || string == "Insultos" || string == "Frases" {
            let array = dictionaryArray[string] as! [Frases]
            return array.count
        }

        return 0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.arraySections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReuse", for: indexPath) as! CustomCellCollection
        
        let section = arraySections[indexPath.section]
       
        switch section {
        case "Imagens":
            let array = arrayImagens[indexPath.row]
            cell.imagemCell.isHidden = false
            cell.labelCell.isHidden = true
            cell.imagemCell.image = array.imagem
            cell.categoria = "Plexel"
            cell.autor = array.autor
            
        case "Notícias":
            let array = arrayNews[indexPath.row]
            cell.imagemCell.isHidden = false
            cell.labelCell.isHidden = true
            cell.imagemCell.image = array.imagem
            cell.categoria = "Noticias"
            cell.autor = array.fonte
            cell.text = array.texto
            cell.titulo = array.titulo
            
        case "Piadas":
            let array = arrayJokes[indexPath.row]
            cell.imagemCell.isHidden = true
            cell.labelCell.isHidden = false
            cell.labelCell.text = array.frase
            cell.categoria = "Frases"
            cell.text = array.frase
            
        case "Fatos Chuck Norris":
            let array = arrayFactsCN[indexPath.row]
            cell.imagemCell.isHidden = true
            cell.labelCell.isHidden = false
            cell.labelCell.text = array.frase
            cell.categoria = "Frases"
            cell.text = array.frase
            
        case "Fatos de Gatos":
            let array = arrayCatFacts[indexPath.row]
            cell.imagemCell.isHidden = true
            cell.labelCell.isHidden = false
            cell.labelCell.text = array.frase
            cell.categoria = "Frases"
            cell.text = array.frase
            
        case "Frases":
            let array = arrayQuotes[indexPath.row]
            cell.imagemCell.isHidden = true
            cell.labelCell.isHidden = false
            cell.labelCell.text = array.frase
            cell.categoria = "Frases"
            cell.text = array.frase

        case "Insultos":
            let array = arrayInsultos[indexPath.row]
            cell.imagemCell.isHidden = true
            cell.labelCell.isHidden = false
            cell.labelCell.text = array.frase
            cell.categoria = "Frases"
            cell.text = array.frase
            
        case "Memes":
            let array = arrayMemes[indexPath.row]
            cell.imagemCell.isHidden = false
            cell.labelCell.isHidden = true
            cell.imagemCell.image = array.imagem
            cell.categoria = "Imagem"
            
        case "Gifs":
            let array = arrayGifs[indexPath.row]
            cell.imagemCell.isHidden = false
            cell.labelCell.isHidden = true
            cell.imagemCell.image = array.imagem
            cell.categoria = "Imagem"
            
        case "Filmes e Seriados":
            let array = arrayFilmes[indexPath.row]
            cell.imagemCell.isHidden = false
            cell.labelCell.isHidden = true
            cell.imagemCell.image = array.imagem
            cell.categoria = "Noticias"
            cell.autor = array.fonte
            cell.text = array.texto
            cell.titulo = array.titulo
            
        case "Esportes":
            let array = arraySports[indexPath.row]
            cell.imagemCell.isHidden = false
            cell.labelCell.isHidden = true
            cell.imagemCell.image = array.imagem
            cell.categoria = "Noticias"
            cell.autor = array.fonte
            cell.text = array.texto
            cell.titulo = array.titulo
            
        default:
            break
        }
        
        
        return cell
    }

}

extension ViewControllerFavs{
    
    func removeAllPopovers(){
        for view in self.view.subviews{
            if view == popoverNoticias || view == popoverImagem || view == popoverLabel || view == popoverPlexels {
                view.removeFromSuperview()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomCellCollection, !entrouPopover{
            
            self.removeAllPopovers()
            
            let blurEffect = UIBlurEffect(style: .dark)
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(blurEffectView)
            
            if cell.categoria == "Imagem"{
                self.popoverImagem.imagem.image = cell.imagemCell.image
                self.popoverImagem.center = self.view.center
                self.view.addSubview(popoverImagem)
            }
            else if cell.categoria == "Plexel" {
                self.popoverPlexels.imagem.image = cell.imagemCell.image
                self.popoverPlexels.center = self.view.center
                self.popoverPlexels.autor.text = cell.autor
                self.view.addSubview(popoverPlexels)
            }
            else if cell.categoria == "Noticias"{
                self.popoverNoticias.imagem.image = cell.imagemCell.image
                self.popoverNoticias.titulo.text = cell.titulo
                self.popoverNoticias.texto.text = cell.text
                self.popoverNoticias.center = self.view.center
                self.view.addSubview(popoverNoticias)
            }
            else if cell.categoria == "Frases"{
                self.popoverLabel.texto.text = cell.text
                self.popoverLabel.center = self.view.center
                self.view.addSubview(popoverLabel)
            }
            entrouPopover = true
        }
    }
    
}

extension ViewControllerFavs: UICollectionViewDelegateFlowLayout{
    
    //Define o layout das celulas de acordo com o espaco escolhido
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Define a distancia do layout para as bordas
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //Define o espaco entre as celulas
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    //Define o espaco entre cada linha do layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
        
}

extension ViewControllerFavs {
    
    func loadArrayImagens(entity: String) -> [Imagens]? {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        
        do {
            let arrayObjects = try manageContext.fetch(fetchRequest)
            return parsingImages(arrayObjects: arrayObjects, entidade: entity)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
    
 
    func parsingImages(arrayObjects: [NSManagedObject], entidade: String) -> [Imagens]?{

        var array = [Imagens]()
        
        for images in arrayObjects {
            var obj = Imagens()
            guard let uiImage = images.value(forKey: "imageData") as? Data else {return nil}
            if (entidade == "GifData"){
                guard let imagem = UIImage.gifImageWithData(uiImage) else {return nil}
                obj.imagem = imagem
            }else {
                guard let imagem = UIImage(data: uiImage) else {return nil}
                obj.imagem = imagem
            }
            guard let id = images.value(forKey: "id") as? Int64 else {return nil}
            if (entidade == "FavoriteImage"){
                guard let autor = images.value(forKey: "autor") as? String else {return nil}
                obj.autor = autor
            }else {
                obj.autor = "Desconhecido"
            }
            
            obj.id = id
            array.append(obj)
        }
        
        if array.count == 0 {
            return nil
        }
        
        return array
    }
    
    
    
    func loadArrayFrases(entity: String) -> [Frases]? {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        
        do {
            let arrayObjects = try manageContext.fetch(fetchRequest)
            return parsingTexts(arrayObjects: arrayObjects)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    
    func parsingTexts(arrayObjects: [NSManagedObject]) -> [Frases]?{
    
        var array = [Frases]()
        for object in arrayObjects {
            
            var obj = Frases()
            
            guard let text = object.value(forKey: "texto") as? String else {return nil}
            guard let id = object.value(forKey: "id") as? Int64 else {return nil}
            
            obj.frase = text
            obj.id = id
            
            array.append(obj)
        }
        
        if array.count == 0 {
            return nil
        }
        
        
        return array
        
    }
    
    
    func loadNews(entidade: String) -> [Noticias]? {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entidade)
        
        do {
            let arrayObjects = try manageContext.fetch(fetchRequest)
            return parsingNews(arrayObjects: arrayObjects)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func parsingNews(arrayObjects: [NSManagedObject]) -> [Noticias]? {
        
        var array = [Noticias]()
        
        for object in arrayObjects {
            var obj = Noticias()
            guard let id = object.value(forKey: "id") as? Int64 else {return nil}
            guard let imageData = object.value(forKey: "imageData") as? Data else {return nil}
            guard let texto = object.value(forKey: "texto") as? String else {return nil}
            guard let titulo = object.value(forKey: "titulo") as? String else {return nil}
            guard let fonte = object.value(forKey: "autor") as? String else {return nil}
            obj.id = id
            obj.texto = texto
            obj.imagem = UIImage(data: imageData)!
            obj.titulo = titulo
            obj.fonte = fonte
            array.append(obj)
        }
        
        if array.count == 0 {
            return nil
        }
        
        
        return array
    }
    
    
    func setarConteudo(){
        arraySections = [String]()
        if let array = loadArrayImagens(entity: "FavoriteImage"){
            arrayImagens = array
            arraySections.append("Imagens")
            dictionaryArray.updateValue(arrayImagens as AnyObject, forKey: "Imagens")
        }
        
        if let array = loadArrayImagens(entity: "MemesData"){
            arrayMemes = array
            arraySections.append("Memes")
            dictionaryArray.updateValue(arrayMemes as AnyObject, forKey: "Memes")
        }
        
        if let array = loadArrayImagens(entity: "GifData"){
            arrayGifs = array
            arraySections.append("Gifs")
            dictionaryArray.updateValue(arrayGifs as AnyObject, forKey: "Gifs")
        }
        
        if let array = loadNews(entidade: "NewsData"){
            arrayNews = array
            arraySections.append("Notícias")
            dictionaryArray.updateValue(arrayNews as AnyObject, forKey: "Notícias")
        }
        
        if let array = loadNews(entidade: "FilmesData"){
            arrayFilmes = array
            arraySections.append("Filmes e Seriados")
            dictionaryArray.updateValue(arrayFilmes as AnyObject, forKey: "Filmes e Seriados")
        }
        
        if let array = loadNews(entidade: "SportsData"){
            arraySports = array
            arraySections.append("Esportes")
            dictionaryArray.updateValue(arraySports as AnyObject, forKey: "Esportes")
        }
        
        if let array = loadArrayFrases(entity: "JokesData"){
            arrayJokes = array
            arraySections.append("Piadas")
            dictionaryArray.updateValue(arrayJokes as AnyObject, forKey: "Piadas")
        }
        
        if let array = loadArrayFrases(entity: "QuoteData"){
            arrayQuotes = array
            arraySections.append("Frases")
            dictionaryArray.updateValue(arrayQuotes as AnyObject, forKey: "Frases")
        }
        
        if let array = loadArrayFrases(entity: "InsultoData"){
            arrayInsultos = array
            arraySections.append("Insultos")
            dictionaryArray.updateValue(arrayInsultos as AnyObject, forKey: "Insultos")
        }
        
        if let array = loadArrayFrases(entity: "FactsCNData"){
            arrayFactsCN = array
            arraySections.append("Fatos Chuck Norris")
            dictionaryArray.updateValue(arrayFactsCN as AnyObject, forKey: "Fatos Chuck Norris")
        }
        
        if let array = loadArrayFrases(entity: "CatFactsData"){
            arrayCatFacts = array
            arraySections.append("Fatos de Gatos")
            dictionaryArray.updateValue(arrayCatFacts as AnyObject, forKey: "Fatos de Gatos")
        }
        
        self.collectionView.reloadData()
    }
    
    
}

