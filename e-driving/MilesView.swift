//
//  MilesView.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class MileLabel: UILabel {

}

@IBDesignable
class MilesView: NibView {
    @IBOutlet weak var mileLabel: UILabel! {
        didSet { renderMile() }
    }
    @IBInspectable var mile: String? {
        didSet { renderMile() }
    }
    private func renderMile() {
        mileLabel?.text = mile
    }
    
    @IBOutlet weak var mileView: UIView! {
        didSet { renderColor() }
    }
    @IBInspectable var mileColor: UIColor? {
        didSet { renderColor() }
    }
    private func renderColor() {
        mileView?.backgroundColor = mileColor
    }
    
    @IBOutlet weak var positionLabel: PositionLabel! {
        didSet { renderPosition() }
    }
    @IBInspectable var title: String? {
        didSet { renderPosition() }
    }
    @IBInspectable var address: String? {
        didSet { renderPosition() }
    }
    @IBInspectable var circleColor: UIColor? {
        didSet { renderPosition() }
    }
    private func renderPosition() {
        positionLabel?.titleLabel?.text = title?.uppercaseString
        positionLabel?.addressLabel?.text = address
        positionLabel?.circleView?.borderColor = circleColor
    }
}