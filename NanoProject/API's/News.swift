//
//  News.swift
//  NanoProject
//
//  Created by Daniel Leal on 26/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//


import Alamofire
import SwiftyJSON
import UIKit


class News : UIView {
    
    //Variaveis de busca
    var country = String()
    var urlImagem: URL?
    
    //Key
    let apiKey = URLQueryItem(name: "apiKey", value: "21bf3a61068e4b61a3a5d06a0eed1963")
    
    //ENDPOINTS
    var topHeadLinesUrl = URLComponents(string: "https://newsapi.org/v2/top-headlines?")
    var everythingUrl = URLComponents(string: "https://newsapi.org/v2/everything?")
    var sourcesUrl = URLComponents(string: "https://newsapi.org/v2/sources?") // convenience endpoint for tracking publishers

    //Funcoes
    
    func searchTopHeadlines (){
        let pais = URLQueryItem(name: "country", value: "br")
        topHeadLinesUrl?.queryItems?.append(pais)
        topHeadLinesUrl?.queryItems?.append(apiKey)
        guard let url = topHeadLinesUrl else {return}
        Alamofire.request(url).responseJSON { (data) in
            
            let json = JSON(data.result.value!)
            guard let dicionario = json.dictionaryObject else {return}
            guard let artigos = dicionario["articles"] as? [[String: AnyObject]] else {return}
            
            let index = self.generateIndex(limite: dicionario["totalResults"] as! Int)
            let artigo = artigos[index]
            
            self.urlImagem = URL(string: artigo["urlToImage"] as! String)
//            print(artigo)
            print(self.urlImagem!)
        }
    }
    
    func generateIndex(limite: Int) -> Int{
        var index = Int()
        index = Int.random(in: 0...limite - 1)
        return index
    }
}
