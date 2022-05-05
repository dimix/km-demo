//
//  String+Extensions.swift
//  Inspla
//
//  Created by Dimitri Giani on 25/10/2017.
//  Copyright © 2017 Dimitri Giani. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

public extension String {
    static var empty: String = ""
    static var whiteSpace: String = " "
    static var newLine: String = "\n"
    static var hash: String = "#"
    static var at: String = "@"

	var lcfirst: String {
		var result = self
		result.replaceSubrange(result.startIndex...result.startIndex, with: String(self[startIndex]).lowercased())
		return result
	}
	
	var addingURLPercentEncoding: String {
		let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)
		return addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? ""
	}
	
	var localized: String {
		localized()
	}
	
	var boolValue: Bool {
        let value = lowercased()
		if value == "true" || value == "1" || value == "yes" {
			return true
		}
		return false
	}

    init?(utf8Data data: Data) {
        self.init(data: data, encoding: .utf8)
    }

	func substring(range: Range<Int>) -> String {
		let start = index(startIndex, offsetBy: range.lowerBound)
		let end = index(startIndex, offsetBy: range.upperBound)
		
		return String(self[start...end])
	}
	
	func hasHTMLCode() -> Bool {
		let pattern = "<[^>]+>"
		if let expression = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
		{
			let matches = expression.matches(in: self, options: [], range:NSMakeRange(0, self.count))
			
			return matches.count > 0
		}
		
		return false
	}
	
	func HTMLStripped(_ decodeEntities: Bool) -> String {
		let string = replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
		
		if decodeEntities
		{
			let encodedData = data(using: String.Encoding.utf8)!
			let attributedOptions:[NSAttributedString.DocumentReadingOptionKey : Any] = [
				NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html as AnyObject,
				NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue as AnyObject
			]
			
			do {
				let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
				
				return attributedString.string
			}
			catch {
				return self
			}
		}
		
		return string
	}
	
	func stringByStrippingCharactersInSet(_ set: CharacterSet) -> String {
		return components(separatedBy: set).joined(separator: "")
	}
	
	func slug(separator: String = "-", allowWordSeparators: Bool = true, camelized: Bool = false) -> String {
		
		//	Code sample https://github.com/paulyoung/Slugify/blob/master/Slugify/Slugify.swift
		
		var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		if allowWordSeparators {
			chars = chars + "-"
		}
		let charactersSet = CharacterSet(charactersIn: chars)
		let cfString = NSMutableString(string: self) as CFMutableString
		
		CFStringTransform(cfString, nil, kCFStringTransformToLatin, false)
		CFStringTransform(cfString, nil, kCFStringTransformStripCombiningMarks, false)
		CFStringLowercase(cfString, .none)
		
		return String(cfString)									//	Cast to Swift String
			.components(separatedBy: charactersSet.inverted)	//	get array of the words remaining from the CharacterSet
			.filter { $0 != "" }								//	remove empty elements
			.map { return camelized ? $0.capitalized : $0 }		//	apply camelization
			.joined(separator: separator)						//	join with a separator
	}
	
	func localized(_ tableName: String = "", value: String = "", comment: String = "", arguments: [CVarArg]? = nil) -> String {
		var localizedString = NSLocalizedString(self, tableName: tableName, bundle: Bundle.main, value: value, comment: comment)
		
		if let arguments = arguments, arguments.count > 0
		{
			localizedString = String(format: localizedString, arguments: arguments)
		}
		
		return localizedString
	}
	
	func trim() -> String {
		return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	static func requiredAsteriskAttributedString(withColor color: UIColor = .black) -> NSAttributedString {
		let asterisk = NSAttributedString(string: " *", attributes: [NSAttributedString.Key.foregroundColor : color])
		return asterisk
	}
	
	static func placeholderString(_ placeholder: String, baseColor: UIColor = .gray, asteriskColor: UIColor = .red, required: Bool = true) -> NSAttributedString {
		let text = NSMutableAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : baseColor])
		
		if required
		{
			text.append(requiredAsteriskAttributedString(withColor: asteriskColor))
		}
		
		return text
	}
	
	//	MARK: Static methods
	
	static func randomBoundaryString() -> String {
		return UUID().uuidString
	}
	
	static func IANACharsetName() -> String {
		return CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue)) as String
	}
}
