//
//  UIAlertController+Extensions.swift
//
//  Created by Dimitri Giani on 03/11/15.
//  Copyright © 2015 Dimitri Giani. All rights reserved.
//

import Foundation
import UIKit

@available(iOSApplicationExtension, unavailable)
public extension UIAlertController
{
	class func presentAlert(_ controller: UIViewController, title:String?, message:String?, confirmAction: UIAlertAction, cancelAction: UIAlertAction? = nil)
	{
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(confirmAction)
		
		if let cancelAction = cancelAction
		{
			alertController.addAction(cancelAction)
		}
		
		controller.present(alertController, animated: true, completion: nil)
	}
	
	class func presentAlert(_ controller: UIViewController, title:String?, message:String?, actions: [UIAlertAction])
	{
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		actions.forEach { alertController.addAction($0) }
		controller.present(alertController, animated: true, completion: nil)
	}
	
	class func genericOkAction(_ handler:((_ action:UIAlertAction)->Void)? = nil) -> UIAlertAction
	{
		return UIAlertAction.genericOkAction(handler)
	}
	
	class func genericCancelAction(_ title:String? = nil) -> UIAlertAction
	{
		return UIAlertAction.genericCancelAction(title)
	}

    @discardableResult
	class func presentAlert(from viewController: UIViewController,
                            title: String?,
                            message: String?,
                            textFieldSetup: @escaping (UITextField)->(), actions: [UIAlertAction] = [UIAlertAction.genericOkAction()]) -> UIAlertController
	{
		let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
		actions.forEach { controller.addAction($0) }
		
		controller.addTextField(configurationHandler: textFieldSetup)
		
		viewController.present(controller, animated: true, completion: nil)
        
        return controller
	}
    
    @discardableResult
    class func presentAlert(from viewController: UIViewController,
                            title: String?,
                            message: String?,
                            fieldsCount: Int = 1,
                            textFieldsSetup: @escaping ([UITextField])->(), actions: [UIAlertAction] = [UIAlertAction.genericOkAction()]) -> UIAlertController
    {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { controller.addAction($0) }
        
        var fields: [UITextField] = []
        
        for _ in 0..<fieldsCount {
            controller.addTextField { textField in
                fields.append(textField)
            }
        }
        
        textFieldsSetup(fields)
        
        viewController.present(controller, animated: true, completion: nil)
        
        return controller
    }

	class func presentActionSheet(from viewController: UIViewController, title: String?, message: String?, addCancelButton: Bool = true, actions: [UIAlertAction])
	{
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		actions.forEach { alertController.addAction($0) }
		
		if addCancelButton
		{
			alertController.addAction(UIAlertAction.genericCancelAction())
		}
		
		viewController.present(alertController, animated: true, completion: nil)
	}

    @discardableResult
	class func presentActionSheet(from viewController: UIViewController,
                                  title: String?,
                                  message: String?,
                                  addCancelButton: Bool = true,
                                  sourceView: UIView? = nil,
                                  sourceRect: CGRect = .zero,
                                  barButtonItem: UIBarButtonItem? = nil,
                                  actions: [UIAlertAction]) -> UIAlertController
	{
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		actions.forEach { alertController.addAction($0) }
		
		if addCancelButton {
			alertController.addAction(UIAlertAction.genericCancelAction())
		}
		
		if let popoverController = alertController.popoverPresentationController {
            if let barButtonItem = barButtonItem {
                popoverController.barButtonItem = barButtonItem
            } else if let sourceView = sourceView {
                popoverController.sourceView = sourceView
                popoverController.sourceRect = sourceRect
            } else {
                popoverController.sourceView = viewController.view
                popoverController.sourceRect = CGRect(viewController.view.center)
            }
		}
		
		viewController.present(alertController, animated: true, completion: nil)
		
		return alertController
	}
}

public extension UIAlertAction
{
	class func genericOkAction(_ handler:((_ action:UIAlertAction)->Void)? = nil) -> UIAlertAction
	{
		return UIAlertAction(title: "generic.ok".localized, style: .default, handler: handler)
	}
	
	class func genericAction(with title: String, _ handler:((_ action:UIAlertAction)->Void)? = nil) -> UIAlertAction
	{
		return UIAlertAction(title: title, style: .default, handler: handler)
	}
	
	class func destructiveAction(with title: String, _ handler:((_ action:UIAlertAction)->Void)? = nil) -> UIAlertAction
	{
		return UIAlertAction(title: title, style: .destructive, handler: handler)
	}
	
	class func genericCancelAction(_ title:String? = nil, _ handler: ((_ action: UIAlertAction)->Void)? = nil) -> UIAlertAction
	{
		return UIAlertAction(title: (title ?? "generic.cancel".localized), style: .cancel, handler: handler)
	}
}
