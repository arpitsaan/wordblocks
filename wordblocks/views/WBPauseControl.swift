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
        pauseButton = UIButton.init(type: .custom)
        self.addSubview(pauseButton)
        
        pauseButton.setImage(#imageLiteral(resourceName: "pause-button"), for: .normal)
                pauseButton.addStaticWidthConstraint(constant: 48)
                pauseButton.addStaticHeightConstraint(constant: 47.0)
        pauseButton.fillSuperView()
        
        pauseButton.addTarget(self, action: #selector(self.pauseButtonSelector), for: .touchUpInside)
    }
    
    @objc func pauseButtonSelector() {
        NSLog("Pause tapped")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
