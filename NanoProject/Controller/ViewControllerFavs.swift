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

class ViewControllerFavs: UIViewController {
    
    //Collections
    @IBOutlet weak var collectionImagens: UICollectionView!
    @IBOutlet var imagemPopover: popoverImagemView2!
    
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    private let itemsPerRow:CGFloat = 3
    var arrayImagens = [UIImage]()
    var entrouPopoverImagem = false
    var blurEffectView = UIVisualEffectView()
    
    override func viewDidLoad() {
        
        guard let arrayInicial = self.loadImage() else {return}
        arrayImagens = arrayInicial
        self.collectionImagens.reloadData()
        
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

extension ViewControllerFavs: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionImagens{
            return arrayImagens.count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReuse", for: indexPath) as! CustomCellCollection
        cell.imagemView.image = arrayImagens[indexPath.row]
        return cell
    }

}

extension ViewControllerFavs: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomCellCollection, !entrouPopoverImagem{
            self.imagemPopover.imagem.image = cell.imagemView.image
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
    
    func loadImage() -> [UIImage]?{
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteImage")
        
        do {
            let arrayImagensObject = try manageContext.fetch(fetchRequest)
            return parsingImages(arrayObjects: arrayImagensObject)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
    
    func parsingImages(arrayObjects: [NSManagedObject]) -> [UIImage]?{

        var imagensArray = [UIImage]()
        
        for images in arrayObjects {
            guard let uiImage = images.value(forKey: "imageData") as? Data else {return nil}
            guard let imagem = UIImage(data: uiImage) else {return nil}
            imagensArray.append(imagem)
        }
        
        
        return imagensArray
        
    }
    
    
}

//Delegates

extension ViewControllerFavs: DownloadFinish {
    func finish() {
        guard let array = self.loadImage() else {return}
        arrayImagens = array
        self.collectionImagens.reloadData()
    }
    
   
    
    
}
