//
//  ConfigViewController.swift
//  NanoProject
//
//  Created by Guilherme Martins Dalosto de Oliveira on 31/07/19.
//  Copyright © 2019 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {
    
    @IBOutlet weak var CAT: UISwitch!
    @IBOutlet weak var CN: UISwitch!
    @IBOutlet weak var DESIGN: UISwitch!
    @IBOutlet weak var FUNNYINSULTS: UISwitch!
    @IBOutlet weak var GIFS: UISwitch!
    @IBOutlet weak var JOKES: UISwitch!
    @IBOutlet weak var MEMES: UISwitch!
    @IBOutlet weak var MOVIE: UISwitch!
    @IBOutlet weak var MUSIC: UISwitch!
    @IBOutlet weak var NEWS: UISwitch!
    @IBOutlet weak var QUOTE: UISwitch!
    @IBOutlet weak var SPORTS: UISwitch!
    @IBOutlet weak var TV: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CAT.isOn = UserDefaults.standard.bool(forKey: "cat")
        CN.isOn = UserDefaults.standard.bool(forKey: "cn")
        DESIGN.isOn = UserDefaults.standard.bool(forKey: "design")
        FUNNYINSULTS.isOn = UserDefaults.standard.bool(forKey: "insult")
        GIFS.isOn = UserDefaults.standard.bool(forKey: "gifs")
        JOKES.isOn = UserDefaults.standard.bool(forKey: "jokes")
        MEMES.isOn = UserDefaults.standard.bool(forKey: "memes")
        MOVIE.isOn = UserDefaults.standard.bool(forKey: "movies")
        MUSIC.isOn = UserDefaults.standard.bool(forKey: "music")
        NEWS.isOn = UserDefaults.standard.bool(forKey: "news")
        QUOTE.isOn = UserDefaults.standard.bool(forKey: "quotes")
        SPORTS.isOn = UserDefaults.standard.bool(forKey: "sports")
        TV.isOn = UserDefaults.standard.bool(forKey: "tvshow")
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        UserDefaults.standard.set(CAT.isOn, forKey: "cat")
        UserDefaults.standard.set(CN.isOn, forKey: "cn")
        UserDefaults.standard.set(DESIGN.isOn, forKey: "design")
        UserDefaults.standard.set(FUNNYINSULTS.isOn, forKey: "insult")
        UserDefaults.standard.set(GIFS.isOn, forKey: "gifs")
        UserDefaults.standard.set(JOKES.isOn, forKey: "jokes")
        UserDefaults.standard.set(MEMES.isOn, forKey: "memes")
        UserDefaults.standard.set(MOVIE.isOn, forKey: "movies")
        UserDefaults.standard.set(MUSIC.isOn, forKey: "music")
        UserDefaults.standard.set(NEWS.isOn, forKey: "news")
        UserDefaults.standard.set(QUOTE.isOn, forKey: "quotes")
        UserDefaults.standard.set(SPORTS.isOn, forKey: "sports")
        UserDefaults.standard.set(TV.isOn, forKey: "tvshow")

    }
    
    
    
    
    
}
