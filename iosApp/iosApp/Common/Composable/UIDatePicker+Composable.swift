//
//  UIDatePicker+Composable.swift
//  
//
//  Created by Dimitri Giani on 17/02/22.
//

import Foundation
import UIKit

public extension UIDatePicker {
    func datePickerMode(_ mode: Mode) -> Self {
        datePickerMode = mode
        return self
    }

    func minimumDate(_ date: Date) -> Self {
        minimumDate = date
        return self
    }

    func maximumDate(_ date: Date) -> Self {
        maximumDate = date
        return self
    }

    func addTarget(_ target: Any, action: Selector) -> Self {
        addTarget(target, action: action, for: .valueChanged)
        return self
    }
}
