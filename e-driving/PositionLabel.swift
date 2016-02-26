//
//  PositionLabel.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class PositionLabel: NibView {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet { renderTitle() }
    }
    @IBInspectable var title: String? {
        didSet { renderTitle() }
    }
    private func renderTitle() {
        titleLabel?.text = title?.uppercaseString
    }
    
    @IBOutlet weak var addressLabel: UILabel! {
        didSet { renderAddress() }
    }
    @IBInspectable var address: String? {
        didSet { renderAddress() }
    }
    private func renderAddress() {
        addressLabel?.text = address
    }
    
    @IBOutlet weak var circleView: UIView! {
        didSet { renderColor() }
    }
    @IBInspectable var color: UIColor? {
        didSet { renderColor() }
    }
    private func renderColor() {
        circleView?.borderColor = color
    }
}