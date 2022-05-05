//
//  UIActivityIndicatorView+Composable.swift
//  
//
//  Created by Dimitri Giani on 09/08/21.
//

import UIKit

public extension UIActivityIndicatorView {
    func animated() -> Self {
        startAnimating()
        return self
    }

    func color(_ color: UIColor) -> Self {
        self.color = color
        return self
    }
}
