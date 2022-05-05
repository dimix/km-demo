//
//  LC.swift
//  
//
//  Created by Dimitri Giani on 20/03/21.
//

import UIKit

public struct LC {
    public static var top: Constraint { top() }
    public static var bottom: Constraint { bottom() }
    public static var leading: Constraint { leading() }
    public static var trailing: Constraint { trailing() }
    public static var centerX: Constraint { centerX() }
    public static var centerY: Constraint { centerY() }
    
    public static var center: [Constraint] {
        return [LC.centerX, LC.centerY]
    }
    public static var fit: [Constraint] {
        return [LC.top, LC.leading, LC.trailing, LC.bottom]
    }
    public static var fitTop: [Constraint] {
        return [LC.top, LC.leading, LC.trailing]
    }
    public static var fitBottom: [Constraint] {
        return [LC.bottom, LC.leading, LC.trailing]
    }
    
    public static func top(constant: CGFloat = 0, safeArea: Bool = false) -> Constraint {
        if #available(iOS 11.0, *) {
            return equal( safeArea ? \.safeAreaLayoutGuide.topAnchor : \.topAnchor, constant: constant)
        } else {
            return equal(\.topAnchor, constant: constant)
        }
    }
    public static func bottom(constant: CGFloat = 0, safeArea: Bool = false) -> Constraint {
        if #available(iOS 11.0, *) {
            return equal( safeArea ? \.safeAreaLayoutGuide.bottomAnchor : \.bottomAnchor, constant: -constant)
        } else {
            return equal(\.bottomAnchor, constant: -constant)
        }
    }
    public static func leading(constant: CGFloat = 0, safeArea: Bool = false) -> Constraint {
        if #available(iOS 11.0, *) {
            return equal( safeArea ? \.safeAreaLayoutGuide.leadingAnchor : \.leadingAnchor, constant: constant)
        } else {
            return equal(\.leadingAnchor, constant: constant)
        }
    }
    public static func trailing(constant: CGFloat = 0, safeArea: Bool = false) -> Constraint {
        if #available(iOS 11.0, *) {
            return equal( safeArea ? \.safeAreaLayoutGuide.trailingAnchor : \.trailingAnchor, constant: -constant)
        } else {
            return equal(\.trailingAnchor, constant: -constant)
        }
    }
    public static func centerX(constant: CGFloat = 0) -> Constraint {
        return equal(\.centerXAnchor, constant: constant)
    }
    public static func centerY(constant: CGFloat = 0) -> Constraint {
        return equal(\.centerYAnchor, constant: constant)
    }

    public static func top(view: UIView, constant: CGFloat = 0) -> Constraint {
        return equal(\.topAnchor, toView: view, withAnchor: \.bottomAnchor, constant: constant)
    }
    public static func bottom(view: UIView, constant: CGFloat = 0) -> Constraint {
        return equal(\.bottomAnchor, toView: view, withAnchor: \.topAnchor, constant: -constant)
    }
    
    public static func leading(view: UIView, constant: CGFloat = 0) -> Constraint {
        return equal(\.leadingAnchor, toView: view, withAnchor: \.trailingAnchor, constant: constant)
    }
    public static func trailing(view: UIView, constant: CGFloat = 0) -> Constraint {
        return equal(\.trailingAnchor, toView: view, withAnchor: \.leadingAnchor, constant: -constant)
    }
    
    public static func fit(constant: CGFloat, safeArea: Bool = false) -> [Constraint] {
        [
            LC.top(constant: constant, safeArea: safeArea),
            LC.bottom(constant: constant, safeArea: safeArea),
            LC.leading(constant: constant, safeArea: safeArea),
            LC.trailing(constant: constant, safeArea: safeArea)
        ]
    }
    
    public static func fitTop(constant: CGFloat = 0, safeArea: Bool = false) -> [Constraint] {
        [
            LC.top(constant: constant, safeArea: safeArea),
            LC.leading(constant: constant, safeArea: safeArea),
            LC.trailing(constant: constant, safeArea: safeArea)
        ]
    }
    
    public static func fitBottom(constant: CGFloat = 0, safeArea: Bool = false) -> [Constraint] {
        [
            LC.leading(constant: constant, safeArea: safeArea),
            LC.trailing(constant: constant, safeArea: safeArea),
            LC.bottom(constant: constant, safeArea: safeArea)
        ]
    }
    
    public static func fit(top view: UIView, constant: CGFloat = 0) -> [Constraint] {
        [
            equal(\.topAnchor, toView: view, withAnchor: \.bottomAnchor, constant: constant),
            LC.leading,
            LC.trailing,
            LC.bottom
        ]
    }
    
    public static func fit(bottom view: UIView, constant: CGFloat = 0) -> [Constraint] {
        [
            LC.top,
            LC.leading,
            LC.trailing,
            equal(\.bottomAnchor, toView: view, withAnchor: \.topAnchor, constant: -constant),
        ]
    }
    
    public static func fitVerticalBetween(top: UIView, bottom: UIView, constant: CGFloat = 0) -> [Constraint] {
        [
            equal(\.topAnchor, toView: top, withAnchor: \.bottomAnchor, constant: constant),
            LC.leading,
            LC.trailing,
            equal(\.bottomAnchor, toView: bottom, withAnchor: \.topAnchor, constant: -constant),
        ]
    }
    
    public static func height(_ constant: CGFloat) -> Constraint {
        equalDimension(\.heightAnchor, to: constant)
    }
    
    public static func width(_ constant: CGFloat) -> Constraint {
        equalDimension(\.widthAnchor, to: constant)
    }

    public static func center(view: UIView) -> [Constraint] {
        [
            equal(\.centerXAnchor, toView: view, withAnchor: \.centerXAnchor),
            equal(\.centerYAnchor, toView: view, withAnchor: \.centerYAnchor)
        ]
    }
}
