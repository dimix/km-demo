//
//  BaseTableViewCell.swift
//
//  Created by Dimitri Giani on 26/10/2020.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {
	public let containerView = UIView()
	
	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupUI()
		configureView()
	}
	
	required public init?(coder: NSCoder) {
		super.init(coder: coder)
		
		setupUI()
		configureView()
	}
	
	open override func awakeFromNib() {
		super.awakeFromNib()
		
		setupUI()
		configureView()
	}
	
    private func setupUI() {
		containerView.backgroundColor = .clear
        contentView.addSubview(containerView, constraints: LC.fit)
	}
	
    open func replaceContainerViewContent(_ view: UIView) {
        containerView.removeAllSubviews()
        containerView.addSubview(view, constraints: LC.fit)
    }
    
    open func setupClearBackground() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        containerView.backgroundColor = .clear
    }
    
	open func configureView() {
		
	}
	
	open func updateUI() {
		
	}
}
