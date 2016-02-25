//
//  MenuScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class RootViewController: UIViewController, UINavigationControllerDelegate {
	@IBOutlet weak var overlayView: UIView!
	@IBOutlet weak var leading: NSLayoutConstraint!
	@IBOutlet var tapGesture: UITapGestureRecognizer!

	override func viewDidLoad() {
		super.viewDidLoad()
		childNavigationController?.delegate = self
	}

	func controllerWithIndentifier(identifier: String, closure: (UINavigationController, UIViewController) -> () = { $0.viewControllers = [$1] }) -> UIViewController? {
		var result: UIViewController? = nil
		if let nav = childNavigationController {
			if let vc = UIStoryboard(name: identifier, bundle: nil).instantiateInitialViewController() {
				closure(nav, vc)
				result = vc
				view.layoutIfNeeded()
			}
		}
		dismissMenu(nil)
		return result
	}

	var childNavigationController: UINavigationController? {
		for child in childViewControllers {
			if let child = child as? UINavigationController {
				return child
			}
		}
		return nil
	}

	@IBAction func showMenu() {
		leading.constant = 0
		UIView.animateWithDuration(0.25) {
			self.view.layoutIfNeeded()
			self.overlayView.alpha = 0.1
		}
		tapGesture.enabled = true
		print("showMenu")
	}

	@IBAction func dismissMenu(sender: AnyObject?) {
		leading.constant = 1000
		UIView.animateWithDuration(0.25) {
			self.view.layoutIfNeeded()
			self.overlayView.alpha = 0
		}
		tapGesture.enabled = false
		print("dismissMenu")
	}

	@IBAction func navigateBack(sender: AnyObject) {
		childNavigationController?.popViewControllerAnimated(true)
	}
}

extension UIViewController {
	@IBAction func showRootMenu() {
		if let root = self as? RootViewController {
			root.showMenu()
		} else {
			parentViewController?.showRootMenu()
		}
	}
}

class MenuCell: UITableViewCell, TableViewDataNibCell {
	static var nibName = "MenuCell"
	@IBOutlet weak var nameLabel: UILabel!
}

class MenuViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!

	let menu = TableViewDataNib<String, MenuCell>(title: nil)
		.onRender { $0.nameLabel.text = $1 }

	var rootViewController: RootViewController? {
		return parentViewController as? RootViewController
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		menu.source = ["Your Drive", "Feed", "Dashboard", "Car Performance"]
		menu.onSelect {[weak self] (item: String) in
			self?.openItem(item)
			return nil
		}
		connectTableView(tableView, sections: [menu])
		tableView.tableFooterView = UIView()
	}

	func openItem(item: String) {
		weak var root = rootViewController
		root?.controllerWithIndentifier(item)
	}
}
