//
//  BaseNIB.swift
//  CricketInfo
//
//  Created by SarathKumar Sekar on 25/01/24.
//
import Foundation
import UIKit

/// Responsible to load  Xib  from current executable (main bundle) ,  subclass by BaseNib.
class BaseNib: UIView {
    
    // MARK: - Properties
    var view: UIView!
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Setup view from .xib file
        xibSetup()
    }
}

private extension BaseNib {
    
    func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Adding custom subview on top of our view
        addSubview(view)
    }
}

extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
}
