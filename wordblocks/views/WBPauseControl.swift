//
//  WBPauseControl.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 13/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class WBPauseControl: UIView {
    
    var pauseButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    func createView() {
        pauseButton = UIButton.init(type: .system)
        self.addSubview(pauseButton)
        
        pauseButton.setTitle("PAUSE", for: .normal)
        pauseButton.backgroundColor = WBColor.pink
                pauseButton.addStaticWidthConstraint(constant: 50.0)
                pauseButton.addStaticHeightConstraint(constant: 50.0)
        pauseButton.fillSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
