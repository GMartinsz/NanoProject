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

    @IBOutlet var imagemPopover: PopoverImagemView2!
    
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    private let itemsPerRow:CGFloat = 3
    
    //Arrays
    var arrayImagens = [Imagens]()
    var frasesChuckNorris = [Frases]()
    var arrayMemes = [Imagens]()
    var arrayNews = [Noticias]()
    var arrayFactsCN = [Frases]()
    var arrayQuotes = [Frases]()
    var arrayJokes = [Frases]()
    var arrayInsultos = [Frases]()
    var arrayCatFacts = [Frases]()
    var arraySections = [String]()
    
    
    //Variaveis normais
    var blurEffectView = UIVisualEffectView()
    var entrouPopoverImagem = false
   
    
    override func viewDidLoad() {
        
        setarConteudo()
    }
    
    deinit {
        print("saiu favoritos")
    }
    
    @IBAction func voltarButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if entrouPopoverImagem {
            self.imagemPopover.removeFromSuperview()
            entrouPopoverImagem = false
            self.blurEffectView.removeFromSuperview()
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
        
        if section == 0 {
            return self.arrayNews.count
        }
        
        return 0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.arraySections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReuse", for: indexPath) as! CustomCellCollection
        
        return cell
    }

}

extension ViewControllerFavs{
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomCellCollection, !entrouPopoverImagem{
            self.imagemPopover.imagemView.image = cell.imagemCell.image
            imagemPopover.center = view.center
            let blurEffect = UIBlurEffect(style: .dark)
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(blurEffectView)
            view.addSubview(imagemPopover)
            self.entrouPopoverImagem = true
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
            return parsingImages(arrayObjects: arrayObjects)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
    
 
    func parsingImages(arrayObjects: [NSManagedObject]) -> [Imagens]?{

        var array = [Imagens]()
        
        for images in arrayObjects {
            var obj = Imagens()
            guard let uiImage = images.value(forKey: "imageData") as? Data else {return nil}
            guard let imagem = UIImage(data: uiImage) else {return nil}
            guard let id = images.value(forKey: "id") as? Int64 else {return nil}
            guard let autor = images.value(forKey: "autor") as? String else {return nil}
            obj.id = id
            obj.imagem = imagem
            obj.autor = autor
  
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
    
    
    func loadNews() -> [Noticias]? {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NewsData")
        
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
            guard let imageData = object.value(forKey: "imageNews") as? Data else {return nil}
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
        if let array = loadArrayImagens(entity: "FavoriteImage"){
            arrayImagens = array
            arraySections.append("Imagens")
        }
        
        if let array = loadArrayImagens(entity: "MemesData"){
            arrayMemes = array
             arraySections.append("Memes")
        }
        
        if let array = loadNews(){
            arrayNews = array
            arraySections.append("Notícias")
        }
        
        if let array = loadArrayFrases(entity: "JokesData"){
            arrayJokes = array
            arraySections.append("Piadas")
        }
        
        if let array = loadArrayFrases(entity: "QuoteData"){
            arrayQuotes = array
            arraySections.append("Frases")
        }
        
        if let array = loadArrayFrases(entity: "InsultoData"){
            arrayInsultos = array
            arraySections.append("Insultos")
        }
        
        if let array = loadArrayFrases(entity: "FactsCNData"){
            arrayFactsCN = array
            arraySections.append("Fatos Chuck Norris")
        }
        
        if let array = loadArrayFrases(entity: "CatFactsData"){
            arrayCatFacts = array
            arraySections.append("Fatos de Gatos")
        }
        
        self.collectionView.reloadData()
    }
    
    
}

