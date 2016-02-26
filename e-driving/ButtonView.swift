//
//  Button.swift
//  e-driving
//
//  Created by Jint on 2/26/16.
//  Copyright © 2016 Interactive Labs. All rights reserved.
//

import Greycats

@IBDesignable
class ButtonView: NibView {
    @IBOutlet weak var buttonView: UIButton! {
        didSet { renderTitle() }
    }
    @IBInspectable var title: String? {
        didSet { renderTitle() }
    }
    private func renderTitle() {
        buttonView?.setTitle(title?.uppercaseString, forState: .Normal)
    }
}