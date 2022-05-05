//
//  UISwitch+Composable.swift
//  
//
//  Created by Dimitri Giani on 24/02/22.
//

import UIKit

public extension UISwitch {
    @discardableResult
    func onTintColor(_ color: UIColor) -> Self {
        onTintColor = color
        return self
    }

    @discardableResult
    func thumbTintColor(_ color: UIColor) -> Self {
        thumbTintColor = color
        return self
    }
}
