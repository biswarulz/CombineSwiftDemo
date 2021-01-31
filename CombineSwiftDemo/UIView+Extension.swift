//
//  UIView+Extension.swift
//  CombineSwiftDemo
//
//  Created by Biswajyoti Sahu on 29/01/21.
//

import UIKit

extension UIView {
    
    func addSubViewForAutoLayout(_ subviews: [UIView]) {
        
        
        for view in subviews {
            
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
