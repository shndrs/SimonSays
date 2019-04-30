//
//  SHNDCircularButton.swift
//  Simon Says
//
//  Created by NP2 on 4/30/19.
//  Copyright © 2019 shndrs. All rights reserved.
//

import SHNDStuffs

class SHNDCircularButton:SHNDButton {
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                alpha = 1.0
            } else {
                alpha = 0.7
            }
        }
    }
}
