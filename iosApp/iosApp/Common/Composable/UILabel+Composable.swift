//
//  UILabel+Composable.swift
//
//  Created by Dimitri Giani on 03/05/21.
//

 
 
import UIKit

public extension UILabel {
    static func label(_ text: Text,
                      numberOfLines: Int = 0,
                      font: UIFont = UIFont.systemFont(ofSize: 17),
                      textColor: UIColor = .white) -> UILabel {
        let label = UILabel()
        label.numberOfLines = numberOfLines
        label.font = font
        label.textColor = textColor
        label.sizeToFit()
        
        return label.setText(text)
    }
    
    func setText(_ text: Text) -> Self {
        switch text {
            case .text(let text):
                self.text = text
            case .attributedString(let string):
                self.attributedText = string
            case .html(let text, let fontSize, let textColor):
                break
        }
        return self
    }
    
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    func numberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    
    func textColor(_ textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }
    
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Self {
        self.lineBreakMode = lineBreakMode
        return self
    }
    
    func lineBreakStrategy(_ lineBreakStrategy: NSParagraphStyle.LineBreakStrategy) -> Self {
        self.lineBreakStrategy = lineBreakStrategy
        return self
    }
    
    func minimumScaleFactor(_ minimumScaleFactor: CGFloat) -> Self {
        self.minimumScaleFactor = minimumScaleFactor
        return self
    }
    
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
}
