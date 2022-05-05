//
//  Values+Extensions.swift
//  
//
//  Created by Dimitri Giani on 08/08/2017.
//

import CoreGraphics
import Foundation

public extension CGFloat
{
	var ceil: CGFloat { return Foundation.ceil(self) }
	var floor: CGFloat { return Foundation.floor(self) }
	var abs: CGFloat { return Swift.abs(self) }
	var int: Int32 { return Int32(self) }
}

public extension Double
{
	var ceil: Double { return Foundation.ceil(self) }
	var floor: Double { return Foundation.floor(self) }
	var abs: Double { return Swift.abs(self) }
	var int: Int { return Int(self) }
	var cgFloat: CGFloat { return CGFloat(self) }
	var float: Float { return Float(self) }
}

public extension Float
{
	var ceil: Float { return Foundation.ceil(self) }
	var floor: Float { return Foundation.floor(self) }
	var abs: Float { return Swift.abs(self) }
	var int: Int { return Int(self) }
	var cgFloat: CGFloat { return CGFloat(self) }
	var double: Double { return Double(self) }
}

public extension CGPoint
{
	init(_ x: CGFloat, _ y: CGFloat) { self.init(x: x, y: y) }
	init(_ x: Float, _ y: Float) { self.init(x: CGFloat(x), y: CGFloat(y)) }
	init(_ x: Double, _ y: Double) { self.init(x: x, y: y) }
	init(_ x: Int, _ y: Int) { self.init(x: x, y: y) }
	
	static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint
	{
		return CGPoint(lhs.x * rhs, lhs.y * rhs)
	}
}

public extension CGSize
{
	init(_ width: CGFloat, _ height: CGFloat) { self.init(width: width, height: height) }
	init(_ width: Float, _ height: Float) { self.init(width: CGFloat(width), height: CGFloat(height)) }
	init(_ width: Double, _ height: Double) { self.init(width: width, height: height) }
	init(_ width: Int, _ height: Int) { self.init(width: width, height: height) }
	
	static func *(lhs: CGSize, rhs: CGFloat) -> CGSize
	{
		return CGSize(lhs.width * rhs, lhs.height * rhs)
	}
}

public extension CGRect
{
	init(origin: CGPoint) { self.init(origin: origin, size: .zero) }
	init(size: CGSize) { self.init(origin: .zero, size: size) }
	init(_ origin: CGPoint) { self.init(origin: origin, size: .zero) }
	init(_ size: CGSize) { self.init(origin: .zero, size: size) }
}
