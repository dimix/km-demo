//
//  UITextField+Composable.swift
//
//  Created by Dimitri Giani on 02/05/21.
//

import UIKit

public extension UITextField {
    static func textField(text: String? = nil,
                          placeholder: String? = nil,
                          borderStyle: BorderStyle = .roundedRect) -> UITextField {
        let view = UITextField()
        view.text = text
        view.borderStyle = borderStyle
        view.placeholder = placeholder
        
        return view
    }

    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }

    func placeholder(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    func attributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) -> Self {
        self.attributedPlaceholder = attributedPlaceholder
        return self
    }
    
    func textColor(_ textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }
    
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    func leftView(_ view: UIView?, leftViewMode: ViewMode) -> Self {
        self.leftView = view
        self.leftViewMode = leftViewMode
        return self
    }
    
    func rightView(_ view: UIView?, rightViewMode: ViewMode) -> Self {
        self.rightView = view
        self.rightViewMode = rightViewMode
        return self
    }
    
    func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }
    
    func isSecureTextEntry(_ isSecureTextEntry: Bool) -> Self {
        self.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    func keyboardAppearance(_ keyboardAppearance: UIKeyboardAppearance) -> Self {
        self.keyboardAppearance = keyboardAppearance
        return self
    }
    
    func inputView(_ inputView: UIView?) -> Self {
        self.inputView = inputView
        return self
    }
    
    func returnKeyType(_ returnKeyType: UIReturnKeyType) -> Self {
        self.returnKeyType = returnKeyType
        return self
    }
    
    func isEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }

    @discardableResult
    func onChangeValue(_ handler: @escaping (String?) -> Void) -> Self {
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: self, queue: nil) { [weak self] notification in
            if notification.object as? UITextField == self {
                handler(self?.text)
            }
        }

        return self
    }

    func defaultDelegate(_ tDelegate: UITextFieldDelegate) -> Self {
        delegate = tDelegate
        return self
    }

    func unregisterChangeNotifications() {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: self)
    }
}

private var UITextFieldDelegateHelperOA: UInt8 = 0

extension UITextField {
    public var delegateHelper: UITextFieldDelegateHelper? {
        get {
            return objc_getAssociatedObject(self, &UITextFieldDelegateHelperOA) as? UITextFieldDelegateHelper
        }
        set {
            objc_setAssociatedObject(self, &UITextFieldDelegateHelperOA, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            delegate = newValue
        }
    }
    
    public func onChange(_ onChange: @escaping UITextFieldDelegateHelper.OnChange) -> Self {
        delegateHelper = UITextFieldDelegateHelper(onChange: onChange)
        return self
    }
}

public class UITextFieldDelegateHelper: NSObject, UITextFieldDelegate {
    public typealias OnChange = (String?) -> Void
    
    let onChange: OnChange
    
    public init(onChange: @escaping OnChange) {
        self.onChange = onChange
        
        super.init()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        onChange(updatedText)
        
        return true
    }
}
