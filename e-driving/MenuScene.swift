//
//  MenuScene.swift
//  e-driving
//
//  Created by Rex Sheng on 2/25/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class RootViewController: UIViewController, UINavigationControllerDelegate, ColorPalette {
	@IBOutlet weak var overlayView: UIView!
	@IBOutlet weak var leading: NSLayoutConstraint!
	@IBOutlet var tapGesture: UITapGestureRecognizer!

	override func viewDidLoad() {
		super.viewDidLoad()
		childNavigationController?.delegate = self
		applyTheme(.Dark)
	}

	func setColor(color: UIColor, category: ColorCategory) {
		switch category {
		case .Background:
			view.backgroundColor = color
			view.window?.backgroundColor = color
		default:
			break
		}
	}

	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
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

	func _child<T>() -> T? {
		for child in childViewControllers {
			if let child = child as? T {
				return child
			}
		}
		return nil
	}

	var childNavigationController: UINavigationController? { return _child() }
	var menuViewController: MenuViewController? { return _child() }

	@IBAction func showMenu() {
		leading.constant = 0
		UIView.animateWithDuration(0.25) {
			self.view.layoutIfNeeded()
			self.overlayView.alpha = 1
			self.childNavigationController?.view.transform = CGAffineTransformMakeScale(0.82, 0.82)
		}
		self.menuViewController?.reload()
		tapGesture.enabled = true
		print("showMenu")
	}

	@IBAction func dismissMenu(sender: AnyObject?) {
		leading.constant = 1000
		UIView.animateWithDuration(0.25) {
			self.view.layoutIfNeeded()
			self.overlayView.alpha = 0
			self.childNavigationController?.view.transform = CGAffineTransformIdentity
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
	@IBOutlet weak var selectedMark: GradientView!
	@IBOutlet weak var markLeft: NSLayoutConstraint!

	override func setSelected(selected: Bool, animated: Bool) {
		markLeft.constant = selected ? 0 : -4
		UIView.animateWithDuration(0.25) {
			self.layoutIfNeeded()
			self.nameLabel.alpha = selected ? 1 : 0.5
		}
	}
}

class MenuViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var experienceView: ExperienceView!

	let menu = TableViewDataNib<String, MenuCell>(title: nil).keepSelection().onRender { $0.nameLabel.text = $1.uppercaseString }

	var rootViewController: RootViewController? {
		return parentViewController as? RootViewController
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		experienceView.captionLabel.text = "EXPERT"
		experienceView.maxExperience = 500
		experienceView.experienceFormat = { "\($0)/\($1)" }
		menu.source = ["Driver Score", "Feed", "Car Performance", "Dashboard"]
		menu.onSelect {[weak self] (item: String) in
			self?.openItem(item)
			return nil
		}
		connectTableView(tableView, sections: [menu])
		tableView.tableFooterView = UIView()
		tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: .None)
	}

	func reload() {
		experienceView.experience = 335
	}

	func openItem(item: String) {
		weak var root = rootViewController
		root?.controllerWithIndentifier(item)
	}
}
