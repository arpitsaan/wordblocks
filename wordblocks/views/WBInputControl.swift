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
    var correctButton = UIButton()
    var incorrectButton = UIButton()
    var containerStackView = UIStackView()

    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }

    //ui
    private func createView() {
        //correct button
        correctButton = UIButton.init(type: .custom)
        incorrectButton.setImage(#imageLiteral(resourceName: "red-button-normal"), for: .normal)
        incorrectButton.setImage(#imageLiteral(resourceName: "red-button-pressed"), for: .highlighted)
        correctButton.addStaticHeightConstraint(constant: 118)
        correctButton.addStaticWidthConstraint(constant: 137)
        correctButton.addTarget(self, action: #selector(self.didTapCorrectButton), for: .touchUpInside)
        
        //incorrect button
        incorrectButton = UIButton.init(type: .custom)
        incorrectButton.setImage(#imageLiteral(resourceName: "green-button-normal"), for: .normal)
        incorrectButton.setImage(#imageLiteral(resourceName: "green-button-pressed"), for: .highlighted)
        incorrectButton.addStaticHeightConstraint(constant: 118)
        incorrectButton.addStaticWidthConstraint(constant: 137)
        incorrectButton.addTarget(self, action: #selector(self.didTapIncorrectButton), for: .touchUpInside)
        
        //containerStackView
        containerStackView = UIStackView.init(arrangedSubviews: [correctButton, incorrectButton])
        self.addSubview(containerStackView)
        containerStackView.spacing = K.padding.side
        containerStackView.distribution = .fill
        containerStackView.axis = .horizontal
        containerStackView.fillSuperView(UIEdgeInsets.init(top: K.padding.side, left: K.padding.side, bottom: K.padding.side+30, right: K.padding.side))
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
