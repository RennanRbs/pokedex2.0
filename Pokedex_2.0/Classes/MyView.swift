//
//  myView.swift
//  Pokedex_2.0
//
//  Created by Rennan Rebouças on 07/07/19.
//  Copyright © 2019 Rennan Rebouças. All rights reserved.
//

import Foundation
import UIKit

class MyView: UIView {
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {

    }
}
