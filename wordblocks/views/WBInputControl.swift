//
//  WBInputControl.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 14/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class WBInputControl: UIView {
    
    //type
    enum WBInputControlType {
        case correct
        case incorrect
    }
    
    //properties
    var inCorrectButton = UIButton()
    var correctButton = UIButton()
    var containerStackView = UIStackView()

    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }

    //ui
    private func createView() {
        //correct button
        inCorrectButton = UIButton.init(type: .custom)
        inCorrectButton.setImage(#imageLiteral(resourceName: "red-button-normal"), for: .normal)
        inCorrectButton.setImage(#imageLiteral(resourceName: "red-button-pressed"), for: .highlighted)
        inCorrectButton.addStaticHeightConstraint(constant: 111)
        inCorrectButton.addStaticWidthConstraint(constant: 111)
        inCorrectButton.addTarget(self, action: #selector(self.didTapCorrectButton), for: .touchUpInside)
        
        //incorrect button
        correctButton = UIButton.init(type: .custom)
        correctButton.setImage(#imageLiteral(resourceName: "green-button-normal"), for: .normal)
        correctButton.setImage(#imageLiteral(resourceName: "green-button-pressed"), for: .highlighted)
        correctButton.addStaticHeightConstraint(constant: 111)
        correctButton.addStaticWidthConstraint(constant: 111)
        correctButton.addTarget(self, action: #selector(self.didTapIncorrectButton), for: .touchUpInside)
        
        //containerStackView
        containerStackView = UIStackView.init(arrangedSubviews: [inCorrectButton, correctButton])
        self.addSubview(containerStackView)
        containerStackView.spacing = K.padding.side
        containerStackView.distribution = .fillEqually
        containerStackView.axis = .horizontal
        containerStackView.fillSuperView(UIEdgeInsets.init(top: K.padding.side, left: K.padding.side, bottom: K.padding.side+24.0, right: K.padding.side))
    }
    
    @objc func didTapCorrectButton() {
        NSLog("CorrectButton")
    }
    
    @objc func didTapIncorrectButton() {
        NSLog("IncorrectButton")
    }
    
    //misc
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
