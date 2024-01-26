//
//  UIView+Extension.swift
//  CricketInfo
//
//  Created by SarathKumar Sekar on 25/01/24.
//

import Foundation
import UIKit

extension UIView {
    
    func updateLayer(color: UIColor, radius: CGFloat, width: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func defaultLayer() {
        updateLayer(color: .clear, radius: 8.0, width: 0)
    }
}
