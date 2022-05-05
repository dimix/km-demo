//
//  UIImageView+Composable.swift
//
//  Created by Dimitri Giani on 03/05/21.
//

import UIKit

public extension UIImageView {
    func contentMode(_ contentMode: ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
    
    func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }

    func clipsToBounds(_ clipsToBounds: Bool) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }
}
