//
//  Functions.swift
//  NanoProject
//
//  Created by Guilherme Martins Dalosto de Oliveira on 29/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum typeTextObject {
    case simple
    case quotes
}

class Functions {
    
    // Get API key
    func getText(type: typeTextObject, from url: String, key: String, completion: @escaping (String) -> ()) {
        Alamofire.request(url, method: .get, parameters: [:], encoding: JSONEncoding.default, headers: ["Accept": "application/json"]).responseData { (responseData) in
            var value = ""
            let json = JSON(responseData.result.value!)
            let dict = json.dictionaryObject
            switch type {
            case .quotes:
                let quoteDict = dict!["quote"] as! [String: AnyObject]
                value = quoteDict["body"] as! String
            default:
                value = dict![key] as! String
            }
            completion(value)
        }
    }
    
    //News
    func searchTopHeadlines (topHeadLinesUrl: URLComponents, pais: String, apiKey: URLQueryItem, completion: @escaping noticia ){
        
        let paisUrl = URLQueryItem(name: "country", value: pais)
        var aux = topHeadLinesUrl
        aux.queryItems?.append(paisUrl)
        aux.queryItems?.append(apiKey)
        
        Alamofire.request(aux).responseJSON { (data) in
            
            let json = JSON(data.result.value!)
            guard let dicionario = json.dictionaryObject else {return}
            guard let artigos = dicionario["articles"] as? [[String: AnyObject]] else {return}
            
            let index = self.generateIndex(limite: artigos.count)
            let artigo = artigos[index]
            guard let urlImagem = URL(string: artigo["urlToImage"] as! String) else {return}
            self.baixarImagem(url: urlImagem, completion: { (image) in
                completion(image, artigo)
            })
            
        }
    }
    
    
    
    func generateIndex(limite: Int) -> Int{
        var index = Int()
        index = Int.random(in: 0...limite - 1)
        return index
    }
    
    
    
    func baixarImagem(url: URL, completion: @escaping (UIImage?) -> Void){
        var imagem: UIImage?
        
        Alamofire.request(url, method: .get).responseData { response in
            guard let imageData = response.result.value else {
                return
            }
            imagem = UIImage(data: imageData)
            completion(imagem)
        }
    }
    
    
    
    
    
    
    
    
}