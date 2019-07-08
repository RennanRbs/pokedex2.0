//
//  Extensions.swift
//  Pokedex_2.0
//
//  Created by Rennan Rebouças on 07/07/19.
//  Copyright © 2019 Rennan Rebouças. All rights reserved.
//

import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
