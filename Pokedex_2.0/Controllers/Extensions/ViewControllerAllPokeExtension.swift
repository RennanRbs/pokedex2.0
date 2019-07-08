//
//  ViewControllerAllPokeExtension.swift
//  Pokedex_2.0
//
//  Created by Rennan Rebouças on 07/07/19.
//  Copyright © 2019 Rennan Rebouças. All rights reserved.
//

import Foundation
import UIKit


extension ViewControllerAllPoke {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }

    func setup()  {
        view.addSubview(upButton)
        view.addSubview(downButton)
        view.addSubview(greeLight)
        NSLayoutConstraint.activate([
            greeLight.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -267),
            greeLight.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 127),
            greeLight.widthAnchor.constraint(equalToConstant: 44),
            greeLight.heightAnchor.constraint(equalToConstant: 44),
            upButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80),
            upButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 280),
            downButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80),
            downButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 280),
            ])
    }

    
    @objc func navigate() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func animationLeds() {
        let imagesRed: [UIImage] = [#imageLiteral(resourceName: "vazio"), #imageLiteral(resourceName: "green"), #imageLiteral(resourceName: "vazio")]
        
        greeLight.image = UIImage.animatedImage(with: imagesRed, duration: 1)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionViewCellPokemon
        cell.labelPokemon.text = pokemonName[indexPath.item]
        return cell
    }
    
    func setupViewController()  {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(navigate))
        swipeGesture.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeGesture)
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(patternImage: UIImage(named: "pokedex02")!)
    }
    
    func setupCollection()  {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 100, height: 120)
        
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(CollectionViewCellPokemon.self, forCellWithReuseIdentifier: cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        collectionview.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        collectionview.layer.borderWidth = 3.0
        collectionview.layer.cornerRadius = 13
        collectionview.clipsToBounds = true
        self.view.addSubview(collectionview)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            collectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            collectionview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            collectionview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
            ])
    }

}
