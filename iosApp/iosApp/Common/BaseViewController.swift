//
//  BaseViewController.swift
//
//  Created by Dimitri Giani on 25/02/16.
//  Copyright © 2016 Dimitri Giani. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController
{
	@IBOutlet
    public weak var loadingView: UIView?
	@IBOutlet
    public var loadingIndicatorView: UIActivityIndicatorView?
	
	internal var viewControllerName: String {
		return classForCoder.description().components(separatedBy: ".").last ?? "Unknown"
	}
	
    open var useLargeTitles: Bool {
		return false
	}
    open var useLargeTitlesForSecondaryControllers: Bool {
		return false
	}
	public var isLoading: Bool = false
	public var analyticsTrackingActive: Bool = true
	public var statusBarStyle: UIStatusBarStyle?
	public var supportedOrientations: UIInterfaceOrientationMask?
    open var tabbarItemTitle: String {
		return ""
	}
	
	override open var preferredStatusBarStyle:UIStatusBarStyle
	{
		return self.statusBarStyle ?? super.preferredStatusBarStyle
	}
	
	override open var supportedInterfaceOrientations:UIInterfaceOrientationMask
	{
		return supportedOrientations ?? super.supportedInterfaceOrientations
	}
	
    override open func viewDidLoad()
	{
        super.viewDidLoad()
		
		if #available(iOS 11.0, *)
		{
			if let navigationController = navigationController, useLargeTitles
			{
				navigationController.navigationBar.prefersLargeTitles = true
				if navigationController.viewControllers.count == 1 {
					navigationItem.largeTitleDisplayMode = .automatic
				} else if navigationController.viewControllers.count > 1 && useLargeTitlesForSecondaryControllers {
					navigationItem.largeTitleDisplayMode = .automatic
				} else {
					navigationItem.largeTitleDisplayMode = .never
				}
            } else {
                navigationItem.largeTitleDisplayMode = .never
            }
		}
		
		self.setLoadingViewVisible(false)
	}
	
	//	MARK: Actions
	
	@IBAction open func dismissModal()
	{
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction open func dismissNavigation()
	{
		let _ = navigationController?.popViewController(animated: true)
	}
	
	//	MARK: Loading
	
	open func setLoadingViewVisible(_ visible:Bool)
	{
		isLoading = visible
		loadingView?.isHidden = !visible
		if visible
		{
			loadingIndicatorView?.startAnimating()
		}
		else
		{
			loadingIndicatorView?.stopAnimating()
		}
	}
	
	//	MARK: Utility accessorts
	
	open func tabBarItemTitle() -> String?
	{
		return nil
	}
	
	@objc open func dismissKeyboard()
	{
		view.endEditing(true)
	}
	
	//	MARK: UI

    @objc
	open func updateUI()
	{
		//
	}
}
