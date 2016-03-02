//
//  MechanicCell.swift
//  e-driving
//
//  Created by Jint on 3/2/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

class MechanicCell: UITableViewCell, TableViewDataNibCell {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var miles: UILabel!

	static var nibName = "MechanicCell"

//	var name: String! {
//		didSet {
//			nameLabel.attributedText = NSAttributedString(string: name.uppercaseString, attributes: [
//				NSKernAttributeName: 2,
//				NSForegroundColorAttributeName: nameLabel.textColor,
//				NSFontAttributeName: nameLabel.font
//				])
//		}
//	}
//	
//	override func setSelected(selected: Bool, animated: Bool) {
//		UIView.animateWithDuration(0.25) {
//			self.selectedMark.alpha = selected ? 1 : 0
//			self.nameLabel.alpha = selected ? 1 : 0.5
//		}
//	}
}
