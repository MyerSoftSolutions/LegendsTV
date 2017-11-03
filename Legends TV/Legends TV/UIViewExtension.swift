//
//  UIViewExtension.swift
//  Legends TV
//
//  Created by Joel Myers on 10/30/17.
//  Copyright © 2017 Legends Media. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
   
    /// Helper method to init and setup the view from the Nib.
    func xibSetup() {
        let view = loadFromNib()
        addSubview(view)
        stretch(view: view)

    }
    
    /// Method to init the view from a Nib.
    ///
    /// - Returns: Optional UIView initialized from the Nib of the same class name.
    func loadFromNib<T: UIView>() -> T {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)
        let nibName = String(describing: selfType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Error loading nib with name \(nibName)")
        }
        
        return view
    }
    
    func stretch(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
