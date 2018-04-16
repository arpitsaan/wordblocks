//
//  WBLivesView.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 13/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class WBLivesView: UIView {

    //properties
    var lifeView1 = WBLifeView()
    var lifeView2 = WBLifeView()
    var lifeView3 = WBLifeView()
    
    var containerStackView = UIStackView()
    
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    //ui
    func createView() {
        //stackview
        containerStackView = UIStackView.init(arrangedSubviews: [lifeView1, lifeView2, lifeView3])
        self.addSubview(containerStackView)
        containerStackView.fillSuperView()
        containerStackView.spacing = K.padding.side
        containerStackView.distribution = .fill
        containerStackView.axis = .horizontal
    }

    //misc
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //setters
    func setActiveLives(count: Int) {
        self.lifeView3.setActive()
        self.lifeView2.setActive()
        self.lifeView1.setActive()
        
        if count<3 {
            self.lifeView1.setInactive()
        }
        
        if count<2 {
            self.lifeView2.setInactive()
        }
        
        if count<1 {
            self.lifeView3.setInactive()
        }
    }
}
