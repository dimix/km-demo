//
//  Text+Composable.swift
//
//  Created by Dimitri Giani on 03/05/21.
//



import UIKit

public enum Text {
    case text(String)
    case attributedString(NSAttributedString)
    case html(text: String, fontSize: CGFloat = 15, textColor: UIColor = .white)
}
