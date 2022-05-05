//
//  TableViewLayoutManager.swift
//
//  Created by Dimitri Giani on 07/04/2020.
//  Copyright © 2020 Dimitri Giani. All rights reserved.
//

import apple_common
import UIKit

public class TableViewLayoutManager: NSObject, UITableViewDataSource, UITableViewDelegate {
	private(set) public weak var tableView: UITableView?
	
	public var numberOfSections: ()->Int = { return 1 }
	public var numberOfRowsInSection: (Int)->Int = { _ in return 0 }
	public var cellForIndexPath: (IndexPath)->UITableViewCell = { _ in return UITableViewCell() }
	public var didSelectRowAtIndexPath: (IndexPath)->() = { _ in }
    public var willDisplayCellForIndexPath: (UITableViewCell, IndexPath)->() = { _, _ in }
	public var didEndDisplaying: (UITableViewCell, IndexPath)->() = { _,_ in }
	public var editingStyleForRowAtIndexPath: (IndexPath)->(UITableViewCell.EditingStyle) = { _ in return .none }
	public var commitEditingStyleForRowAtIndexPath: (UITableViewCell.EditingStyle, IndexPath)->() = { _, _ in }
	public var shouldIndentWhileEditingRowAtIndexPath: (IndexPath)->Bool = { _ in return false }
	public var shouldShowMenuForRowAtIndexPath: (IndexPath)->Bool = { _ in return false }
	public var canPerformActionForRowWithSender: (Selector, IndexPath, Any?)->Bool = { _,_,_ in return false }
	public var performActionForRowWithSender: (Selector, IndexPath, Any?)->() = { _,_,_ in }
    public var editActionsForRowAtIndexPath: (IndexPath) -> [UITableViewRowAction]? = { _ in return nil }
	public var viewForHeaderInSection: (Int)->UIView? = { _ in return nil }
	public var heightForHeaderInSection: (Int)->CGFloat = { _ in return 0 }

    public var didScroll: (UIScrollView) -> Void = { _ in }
    public var didReachScrollBottom: (() -> Void)?
	public var willBeginDragging: (UIScrollView)->() = { _ in }

    public var scrollReachOffset: CGFloat = 0

	deinit {
		tableView?.delegate = nil
		tableView?.dataSource = nil
	}
	
	public init(tableView: UITableView?) {
		self.tableView = tableView
		
		super.init()
		
		tableView?.delegate = self
		tableView?.dataSource = self
	}
	
	public func reloadData() {
		tableView?.reloadData()
	}
	
	public func numberOfSections(in tableView: UITableView) -> Int {
		numberOfSections()
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		numberOfRowsInSection(section)
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		cellForIndexPath(indexPath)
	}

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        willDisplayCellForIndexPath(cell, indexPath)
    }

	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		didSelectRowAtIndexPath(indexPath)
	}
	
	public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		commitEditingStyleForRowAtIndexPath(editingStyle, indexPath)
	}
	
	public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		editingStyleForRowAtIndexPath(indexPath)
	}
	
	public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
		shouldIndentWhileEditingRowAtIndexPath(indexPath)
	}
	
	public func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
		shouldShowMenuForRowAtIndexPath(indexPath)
	}
	
	public func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
		canPerformActionForRowWithSender(action, indexPath, sender)
	}
	
	public func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
		performActionForRowWithSender(action, indexPath, sender)
	}
	
	public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		didEndDisplaying(cell, indexPath)
	}
	
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        editActionsForRowAtIndexPath(indexPath)
    }
    
	//	Header
	
	public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		viewForHeaderInSection(section)
	}
	
	public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		heightForHeaderInSection(section)
	}
	
	//	- ScrollView Delegate
	
	public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		willBeginDragging(scrollView)
	}

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll(scrollView)

        if let handler = didReachScrollBottom {
            let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            if distanceFromBottom < (height + scrollReachOffset) {
                handler()
            }
        }
    }
}

class ReordableTableViewLayoutManager: TableViewLayoutManager {
	public var moveRowAtSourceIndexPathToDestinationIndexPath: (IndexPath, IndexPath)->() = { _, _ in }
	
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		moveRowAtSourceIndexPathToDestinationIndexPath(sourceIndexPath, destinationIndexPath)
	}
}
