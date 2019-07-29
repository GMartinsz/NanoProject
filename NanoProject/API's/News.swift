//
//  News.swift
//  NanoProject
//
//  Created by Daniel Leal on 26/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//


import Alamofire

typealias noticia = (UIImage?, [String:Any]) -> Void

class News {
        
    //Variaveis de busca
    var country = String()
    var urlImagem: URL?
    
    //Key
    let apiKey = URLQueryItem(name: "apiKey", value: "21bf3a61068e4b61a3a5d06a0eed1963")
    
    //ENDPOINTS
    var topHeadLinesUrl = URLComponents(string: "https://newsapi.org/v2/top-headlines?")
    var everythingUrl = URLComponents(string: "https://newsapi.org/v2/everything?")
    var sourcesUrl = URLComponents(string: "https://newsapi.org/v2/sources?") // convenience endpoint for tracking publishers

}
