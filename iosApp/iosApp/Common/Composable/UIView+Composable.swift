//
//  UIView+Composable.swift
//
//  Created by Dimitri Giani on 03/05/21.
//

 
 
import UIKit

public extension UIView {
    typealias ViewAction = (UIView) -> Void
    
    var viewId: String? {
        get {
            return accessibilityIdentifier
        }
        set {
            accessibilityIdentifier = newValue
        }
    }

    @discardableResult
    func identifier(_ id: String?) -> Self {
        viewId = id
        return self
    }

    @discardableResult
    func size(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        setDimensionContraints(width: width, height: height)
        return self
    }

    @discardableResult
    func sizeAspectRatio(ratio: CGFloat) -> Self {
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: ratio).isActive = true
        return self
    }

    @discardableResult
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }

    @discardableResult
    func tintColor(_ tintColor: UIColor) -> Self {
        self.tintColor = tintColor
        return self
    }

    @discardableResult
    func backgroundColor(_ backgroundColor: UIColor) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }

    @discardableResult
    func border(_ color: UIColor, width: CGFloat) -> Self {
        borderColor = color
        borderWidth = width
        return self
    }

    @discardableResult
    func cornerRadius(_ cornerRadius: CGFloat) -> Self {
        self.cornerRadius = cornerRadius
        return self
    }

    @discardableResult
    func addShadow(_ color:UIColor?, offset:CGSize?, opacity: CGFloat?, radius:CGFloat?) -> Self {
        setShadow(color, offset: offset, opacity: opacity, radius: radius)
        return self
    }

    @discardableResult
    func isHidden(_ hidden: Bool) -> Self {
        isHidden = hidden
        return self
    }

    @discardableResult
    @available(iOS 11.0, *)
    func directionalLayoutMargins(_ layoutMargins: NSDirectionalEdgeInsets) -> Self {
        self.directionalLayoutMargins = layoutMargins
        if let stackView = self as? UIStackView {
            stackView.isLayoutMarginsRelativeArrangement = true
        }
        return self
    }

    @discardableResult
    func addTopDividerLine(height: CGFloat = 1, color: UIColor = UIColor.black.withAlphaComponent(0.1)) -> Self {
        addSubview(UIView().size(width: nil, height: height).backgroundColor(color), constraints: LC.fitTop)
        return self
    }

    @discardableResult
    func addBottomDividerLine(height: CGFloat = 1, color: UIColor = UIColor.black.withAlphaComponent(0.1)) -> Self {
        addSubview(UIView().size(width: nil, height: height).backgroundColor(color), constraints: LC.fitBottom)
        return self
    }
}

public extension UIView {
    func view<T>(withId id: String, _ type: T.Type) -> T? {
        if viewId == id {
            return self as? T
        }
        
        for view in self.subviews {
            if let view = view.view(withId: id) as? T {
                return view
            }
        }
        
        return nil
    }
    
    func view(withId id: String) -> UIView? {
        view(withId: id, UIView.self)
    }
}
