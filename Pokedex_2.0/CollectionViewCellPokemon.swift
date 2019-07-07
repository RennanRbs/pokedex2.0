//
//  CollectionViewCellPokemon.swift
//  Pokedex_2.0
//
//  Created by Rennan Rebouças on 06/07/19.
//  Copyright © 2019 Rennan Rebouças. All rights reserved.
//

import UIKit

class CollectionViewCellPokemon: UICollectionViewCell {
    
    let imagePokemon: UIImageView = {
        let pokemon = UIImageView(image: UIImage(named: "quem"))
        pokemon.contentMode = .scaleToFill
        pokemon.translatesAutoresizingMaskIntoConstraints = false
        pokemon.layer.cornerRadius = 3
        pokemon.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pokemon.layer.borderWidth = 3
        pokemon.clipsToBounds = true
        return pokemon
        
    }()
    
    let namePokemon : UIImageView = {
        let pokemon = UIImageView()
        pokemon.translatesAutoresizingMaskIntoConstraints = false
        pokemon.layer.cornerRadius = 3
        pokemon.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pokemon.layer.opacity = 0.6
        pokemon.clipsToBounds = true
        return pokemon
        
    }()
    
    let labelPokemon : UILabel = {
        let pokemon = UILabel()
        pokemon.text = "pokemon Name"
        pokemon.sizeToFit()
        pokemon.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pokemon.textAlignment = .center
        pokemon.numberOfLines = 0
        pokemon.translatesAutoresizingMaskIntoConstraints = false
        return pokemon
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        
    }
    
    func setup()  {
        addSubview(imagePokemon)
        addSubview(namePokemon)
        addSubview(labelPokemon)
        NSLayoutConstraint.activate([
            imagePokemon.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imagePokemon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            imagePokemon.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            imagePokemon.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            namePokemon.leftAnchor.constraint(equalTo: leftAnchor),
            namePokemon.rightAnchor.constraint(equalTo: rightAnchor),
            namePokemon.bottomAnchor.constraint(equalTo: bottomAnchor),
            namePokemon.heightAnchor.constraint(equalToConstant: 25),
            labelPokemon.bottomAnchor.constraint(equalTo: bottomAnchor, constant:-4),
            labelPokemon.leftAnchor.constraint(equalTo: leftAnchor),
            labelPokemon.rightAnchor.constraint(equalTo: rightAnchor),
            
            ])
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
