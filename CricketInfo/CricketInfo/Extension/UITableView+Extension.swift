//
//  UITableView+Extension.swift
//  CricketInfo
//
//  Created by SarathKumar Sekar on 25/01/24.
//

import Foundation
import UIKit
 
extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.storyboardIdentifier, for: indexPath) as? T else {
            fatalError("Could not find table view cell with identifier \(T.storyboardIdentifier)")
        }
        return cell
    }
}

extension UITableViewCell {
    
    class func reuseIdentifier() -> String {
        return String(describing: self)
    }
    class func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func setCellSelectionColor(color: UIColor = .white) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = color
        selectedBackgroundView = backgroundView
    }
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension StoryboardIdentifiable where Self: UITableViewCell {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }
extension UITableViewCell: StoryboardIdentifiable { }
