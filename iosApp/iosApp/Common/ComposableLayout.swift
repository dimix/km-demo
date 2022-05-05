//
//  ComposableLayout.swift
//  
//
//  Created by Dimitri Giani on 27/10/2020.
//

import UIKit

public extension UILabel {
	static func label(title: String) -> UILabel {
		let label = UILabel()
		label.text = title
		return label
	}
}

public extension UIImageView {
	static func imageView(imageName: String, size: CGSize) -> UIImageView {
		let icon = UIImageView(image: UIImage(named: imageName))
		icon.setDimensionContraints(width: size.width, height: size.height)
		return icon
	}
}

public extension UIView {
	struct Line {
		let height: CGFloat
		let color: UIColor
		
		public init(height: CGFloat = 1, color: UIColor = .gray) {
			self.height = height
			self.color = color
		}
	}
	
	static func container(withView view: UIView,
						  cornerRadius: CGFloat = 0,
						  backgroundColor: UIColor = .clear,
						  width: CGFloat? = nil,
						  height: CGFloat? = nil,
						  viewConstraints constraints: [Constraint] = []) -> UIView {
		let container = UIView()
		container.cornerRadius = cornerRadius
		container.backgroundColor = backgroundColor
		container.setDimensionContraints(width: width, height: height)
		container.addSubview(view, constraints: constraints)
		
		return container
	}
    
    static func containing(_ view: UIView) -> UIView {
        let container = UIView()
        container.addSubview(view, constraints: LC.fit)
        return container
    }
    
    static func containing(_ view: UIView, constraint: [Constraint]) -> UIView {
        let container = UIView()
        container.addSubview(view, constraints: constraint)
        return container
    }
    
    static func containingCentering(_ view: UIView, constraints: [Constraint] = []) -> UIView {
        let container = UIView()
        container.addSubviewAndCenter(view)
        view.activate(constraints: constraints)
        return container
    }
	
	static func spacer(height: CGFloat = 20, withLine line: Line? = nil) -> UIView {
		let view = UIView()
		view.backgroundColor = .clear
		view.setDimensionContraints(width: nil, height: height)
		
		if let line = line {
			let lineView = UIView()
			lineView.backgroundColor = line.color
			lineView.setDimensionContraints(width: nil, height: line.height)
			view.addSubview(lineView, constraints: [
				equal(\.centerYAnchor),
				equal(\.leadingAnchor),
				equal(\.trailingAnchor)
			])
		}
		
		return view
	}
    
    static func hSpacer(width: CGFloat = 16) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.setDimensionContraints(width: width, height: nil)
        
        return view
    }
}
