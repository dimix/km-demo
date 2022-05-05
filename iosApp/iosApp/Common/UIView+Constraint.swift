//
//  UIView+Constraint.swift
//
//  Created by Dimitri Giani on 25/07/16.
//  Copyright © 2016 Dimitri Giani. All rights reserved.
//

import UIKit

public typealias Constraint = (_ child: UIView, _ parent: UIView) -> NSLayoutConstraint

public extension UIView
{
	//	MARK: - Code from: https://talk.objc.io/
	
	func constrainEqual(_ attribute: NSLayoutConstraint.Attribute, to: AnyObject, multiplier: CGFloat = 1, constant: CGFloat = 0)
	{
		constrainEqual(attribute, to: to, attribute, multiplier: multiplier, constant: constant)
	}
	
	func constrainEqual(_ attribute: NSLayoutConstraint.Attribute, to: AnyObject, _ toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1, constant: CGFloat = 0)
	{
		NSLayoutConstraint.activate([
			NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: to, attribute: toAttribute, multiplier: multiplier, constant: constant)
			])
	}
	
	func constrainEdges(to view: UIView)
	{
		constrainEqual(.top, to: view, .top)
		constrainEqual(.leading, to: view, .leading)
		constrainEqual(.trailing, to: view, .trailing)
		constrainEqual(.bottom, to: view, .bottom)
	}
	
	/// If the `view` is nil, we take the superview.
	@available(iOS 9.0, *)
	func center(in view: UIView? = nil)
	{
		guard let container = view ?? self.superview else { fatalError() }
		
		centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 0).isActive = true
		centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 0).isActive = true
	}

	static var centerSuperviewConstraints: [Constraint] {
		return [
			equal(\.centerXAnchor),
			equal(\.centerYAnchor)
		]
	}
	static var fitToSuperViewConstraints: [Constraint] {
		return [equal(\.topAnchor), equal(\.trailingAnchor), equal(\.bottomAnchor), equal(\.leadingAnchor)]
	}
	
	//	MARK: Insert
	
	func insertSubview(_ view: UIView, at index: Int, constraints: [Constraint])
	{
		insertSubview(view, at: index)
		view.activate(constraints: constraints)
	}
	
	func setDimensionContraints(width: CGFloat?, height: CGFloat?)
	{
		if let width = width
		{
			if widthConstraint != nil
			{
				widthConstraint?.constant = width
			}
			else
			{
				widthAnchor.constraint(equalToConstant: width).isActive = true
			}
		}
		
		if let height = height
		{
			if heightConstraint != nil
			{
				heightConstraint?.constant = height
			}
			else
			{
				heightAnchor.constraint(equalToConstant: height).isActive = true
			}
		}
	}
	
	//	MARK: Add
	
	func addSubview(_ view: UIView, constraints: [Constraint])
	{
		addSubview(view)
		view.activate(constraints: constraints)
	}
	
	func addSubviewAndCenter(_ view: UIView)
	{
		addSubview(view)
		view.activate(constraints: UIView.centerSuperviewConstraints)
	}
	
	//	MARK: Remove and set constraints on demand
	
	func removeConstraint(withAttribute attribute: NSLayoutConstraint.Attribute)
	{
		let toRemove: [NSLayoutConstraint] = constraints.filter { $0.firstAttribute == attribute }
		toRemove.forEach { removeConstraint($0) }
	}
	
	func set(constraintsBasedOnSuperview constraints: [Constraint])
	{
		if let superview = superview
		{
			NSLayoutConstraint.activate(constraints.map { c in
				c(self, superview)
			})
		}
	}
	
	//	MARK: Contraints Activation
	
	func activate(constraints: [Constraint])
	{
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(constraints.map { c in
			c(self, superview!)
		})
	}
}

public func equal<L, Axis>(_ to: KeyPath<UIView, L>) -> Constraint where L: NSLayoutAnchor<Axis> {
	return { view, parent in
		view[keyPath: to].constraint(equalTo: parent[keyPath: to])
	}
}

public func equal<L, Axis>(_ to: KeyPath<UIView, L>, constant: CGFloat) -> Constraint where L: NSLayoutAnchor<Axis> {
	return { view, parent in
		view[keyPath: to].constraint(equalTo: parent[keyPath: to], constant: constant)
	}
}

public func equal<L, Axis>(_ from: KeyPath<UIView, L>, toView: UIView, withAnchor: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
	return { view, parent in
		view[keyPath: from].constraint(equalTo: toView[keyPath: withAnchor], constant: constant)
	}
}

public func equal<L, Axis>(_ from: KeyPath<UIView, L>, to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
	return { view, parent in
		view[keyPath: from].constraint(equalTo: parent[keyPath: to], constant: constant)
	}
}

public func equalDimension<L>(_ keyPath: KeyPath<UIView, L>, to constant: CGFloat) -> Constraint where L: NSLayoutDimension {
	return { view, parent in
		view[keyPath: keyPath].constraint(equalToConstant: constant)
	}
}

public func equal<L, Axis>(_ to: KeyPath<UIView, L>, minimum constant: CGFloat) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: to].constraint(greaterThanOrEqualTo: parent[keyPath: to], constant: constant)
    }
}

public func equal<L, Axis>(_ to: KeyPath<UIView, L>, maximum constant: CGFloat) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: to].constraint(lessThanOrEqualTo: parent[keyPath: to], constant: constant)
    }
}
