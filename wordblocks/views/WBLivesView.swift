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
}
