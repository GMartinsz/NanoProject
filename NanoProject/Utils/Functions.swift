//
//  Functions.swift
//  NanoProject
//
//  Created by Guilherme Martins Dalosto de Oliveira on 29/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import Alamofire
import SwiftyJSON

class Functions {
    
    // Get API key
    func getText(from url: String, key: String, completion: @escaping (String) -> ()) {
        Alamofire.request(url, method: .get, parameters: [:], encoding: JSONEncoding.default, headers: ["Accept": "application/json"]).responseData { (responseData) in
            let json = JSON(responseData.result.value!)
            let dict = json.dictionaryObject
            let value = dict![key] as! String
            completion(value)
        }
    }
    
    //News
    func searchTopHeadlines (topHeadLinesUrl: URLComponents, pais: URLQueryItem, apiKey: URLQueryItem, completion: @escaping noticia ){
        let pais = URLQueryItem(name: "country", value: "br")
        var aux = topHeadLinesUrl
        aux.queryItems?.append(pais)
        aux.queryItems?.append(apiKey)
        
        Alamofire.request(aux).responseJSON { (data) in
            
            let json = JSON(data.result.value!)
            guard let dicionario = json.dictionaryObject else {return}
            guard let artigos = dicionario["articles"] as? [[String: AnyObject]] else {return}
            
            let index = self.generateIndex(limite: dicionario["totalResults"] as! Int)
            let artigo = artigos[index]
            let urlImagem = URL(string: artigo["urlToImage"] as! String)
            
            guard let imagemBaixada = self.baixarImagem(url: urlImagem!) else {return}
            completion(imagemBaixada, artigo)
        }
    }
    
    
    
    func generateIndex(limite: Int) -> Int{
        var index = Int()
        index = Int.random(in: 0...limite - 1)
        return index
    }
    
    
    
    func baixarImagem(url: URL) -> UIImage?{
        var imagem: UIImage?
        
        Alamofire.request(url, method: .get).responseData { response in
            guard let imageData = response.result.value else {
                return
            }
            imagem = UIImage(data: imageData)
            
        }
        return imagem
    }
    
    
    
    
    
    
    
    
}
