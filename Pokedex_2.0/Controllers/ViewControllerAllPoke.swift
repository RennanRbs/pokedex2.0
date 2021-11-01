//
//  ViewControllerAllPoke.swift
//  Pokedex_2.0
//
//  Created by Rennan Rebouças on 06/07/19.
//  Copyright © 2019 Rennan Rebouças. All rights reserved.
//

import UIKit

final class ViewControllerAllPoke: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionview: UICollectionView!
    var cellId = "Cell"
    var pokemonName = [
        "Bulbasaur",
        "Ivysaur",
        "Venusaur",
        "Charmander",
        "Charmeleon",
        "Charizard",
        "Squirtle",
        "Wartortle",
        "Blastoise",
        "Caterpie",
        "Metapod",
        "Butterfree",
        "Weedle",
        "Beedrill",
        "Pidgeotto",
        "Pidgeot",
        "Rattata"
]
    
    var sizeCellCollection: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 400)
        return layout
    }()
    
    let greeLight : UIImageView = {
        let green = UIImageView()
        green.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        green.layer.opacity = 0.5
        green.layer.cornerRadius = 20
        green.clipsToBounds = true
        green.translatesAutoresizingMaskIntoConstraints = false
        return green
    }()

    let upButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "upbutton")!, for: .normal)
        button.alpha = 1.0
        button.layer.cornerRadius = 8
        return button
    }()
    
    let downButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "downbutton")!, for: .normal)
        button.alpha = 1.0
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setup()
        animationLeds()
        setupCollection()
    }
}
