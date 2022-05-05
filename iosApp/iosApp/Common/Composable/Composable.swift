//
//  Composable.swift
//
//  Created by Dimitri Giani on 02/05/21.
//

 
 
import UIKit

public class ZView: UIView {
    public init(_ compose: () -> [(UIView, [Constraint])]) {
        super.init(frame: .zero)
        
        compose().forEach {
            addSubview($0.0, constraints: $0.1)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class VView: UIStackView {
    public init(alignment: UIStackView.Alignment = .fill,
                distribution: UIStackView.Distribution = .fill,
                spacing: CGFloat = 0,
                _ compose: () -> [UIView]) {
        super.init(frame: .zero)
        
        self.alignment = alignment
        self.distribution = distribution
        self.axis = .vertical
        self.spacing = spacing
        
        let views = compose()
        views.forEach { addArrangedSubview($0) }
    }

    public convenience init(alignment: UIStackView.Alignment = .fill,
                distribution: UIStackView.Distribution = .fill,
                spacing: CGFloat = 0,
                @ComposableBuilder views: () -> [UIView]) {
        self.init(alignment: alignment, distribution: distribution, spacing: spacing, {views()})
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class HView: UIStackView {
    public init(alignment: UIStackView.Alignment = .fill,
                distribution: UIStackView.Distribution = .fill,
                spacing: CGFloat = 0,
                _ compose: () -> [UIView]) {
        super.init(frame: .zero)
        
        self.alignment = alignment
        self.distribution = distribution
        self.axis = .horizontal
        self.spacing = spacing
        
        let views = compose()
        views.forEach { addArrangedSubview($0) }
    }

    public convenience init(alignment: UIStackView.Alignment = .fill,
                            distribution: UIStackView.Distribution = .fill,
                            spacing: CGFloat = 0,
                            @ComposableBuilder views: () -> [UIView]) {
        self.init(alignment: alignment, distribution: distribution, spacing: spacing, {views()})
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
