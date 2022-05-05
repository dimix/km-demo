//
//  UIButton+Composable.swift
//
//  Created by Dimitri Giani on 03/05/21.
//

 
 
import UIKit

public extension UIButton {
    static func button(text: String,
                       font: UIFont = UIFont.systemFont(ofSize: 15, weight: .medium),
                       textColor: UIColor = .white) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(textColor, for: .normal)
        return button
    }

    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.titleLabel?.textAlignment = textAlignment
        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }

    @discardableResult
    func setIcon(_ image: UIImage?, state: UIControl.State = .normal) -> Self {
        self.setImage(image, for: state)
        return self
    }

    @discardableResult
    func title(_ title: String, state: UIControl.State = .normal) -> Self {
        self.setTitle(title, for: state)
        return self
    }

    @discardableResult
    func textColor(_ textColor: UIColor, state: UIControl.State = .normal) -> Self {
        self.setTitleColor(textColor, for: state)
        return self
    }

    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }

    @discardableResult
    func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
}
