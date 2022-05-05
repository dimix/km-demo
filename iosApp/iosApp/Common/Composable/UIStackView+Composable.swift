//
//  UIStackView+Composable.swift
//  
//
//  Created by Dimitri Giani on 23/11/21.
//

import UIKit

public extension UIStackView {
    func margins(_ margins: UIEdgeInsets) -> Self {
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }
}
