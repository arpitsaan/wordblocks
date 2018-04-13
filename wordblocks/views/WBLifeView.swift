//
//  WBLifeView.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 13/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class WBLifeView: UIView {
    
    //properties
    var isActive = true
    var goneImageView = UIImageView()
    
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    //ui
    private func createView() {
        goneImageView = UIImageView(image: UIImage.init(named: "live-heart-active"))
        goneImageView.contentMode = UIViewContentMode.scaleAspectFit
        self.addSubview(goneImageView)
        goneImageView.addStaticHeightConstraint(constant: 27)
        goneImageView.addStaticWidthConstraint(constant: 22)
        goneImageView.fillSuperView()
        
        goneImageView.backgroundColor = UIColor.yellow
    }
    
    //setters
    func setActive() {
        self.alpha = 1.0
    }
    
    func setInactive() {
        self.alpha = 0.2
    }
    
    //misc
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
