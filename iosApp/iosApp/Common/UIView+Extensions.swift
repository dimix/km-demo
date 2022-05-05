//
//  UIViewExtensions.swift
//
//  Created by Dimitri Giani on 20/10/15.
//  Copyright © 2015 Dimitri Giani. All rights reserved.
//

import UIKit

public extension UIView
{
    var isVisibleToUser: Bool {
        window != nil
    }
    
	//	MARK: Frame properties
	
	var frameSize:CGSize {
		get {
			return self.frame.size
		}
		set {
			var frame:CGRect = self.frame
			frame.size = newValue
			self.frame = frame
		}
	}
	
	var frameOrigin:CGPoint {
		get {
			return self.frame.origin
		}
		set {
			var frame:CGRect = self.frame
			frame.origin = newValue
			self.frame = frame
		}
	}
	
	var cornerRadius:CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			clipsToBounds = true
			layer.cornerRadius = newValue
		}
	}
	
	var borderWidth:CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}
	
	var borderColor:UIColor? {
		get {
			return (layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil)
		}
		set {
			layer.borderColor = newValue?.cgColor
		}
	}
	
	var scale: CGFloat {
		return UIScreen.main.scale
	}
	
	//	MARK: Subviews
	
	func removeAllSubviews() {
        if let stackView = self as? UIStackView {
            stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        } else {
            subviews.forEach { $0.removeFromSuperview() }
        }
	}
	
	//	MARK: Shadow
	
	func setShadow(_ color:UIColor?, offset:CGSize?, opacity: CGFloat?, radius:CGFloat?)
	{
        isOpaque = false
        clipsToBounds = false
        
		if let shadowColor = color {
			layer.shadowColor = shadowColor.cgColor
		}
		
		if let shadowOffset = offset {
			layer.shadowOffset = shadowOffset
		}
		
		if let shadowOpacity = opacity {
			layer.shadowOpacity = Float(shadowOpacity)
		}
		
		if let shadowRadius = radius {
			layer.shadowRadius = shadowRadius
		}
	}
	
	func removeShadow()
	{
		layer.shadowRadius = 0
		layer.shadowOpacity = 0
		layer.shadowOffset = .zero
		layer.shadowColor = UIColor.clear.cgColor
	}

    //  MARK: UIImage
    
    func snapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        return renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
    
	//	MARK: Class methods
	
	class func fromNib<T:UIView>(withName name:String) -> T
	{
		return Bundle.main.loadNibNamed(name, owner: nil, options: nil)!.first as! T
	}
	
	class func fromNib<T:UIView>(index: Int = 0) -> T
	{
		let name = String(describing: T.self)
		return Bundle.main.loadNibNamed(name, owner: nil, options: nil)![index] as! T
	}
}
