//
//  WBInputControl.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 14/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

protocol WBInputControlDelegate {
    func didTapCorrectButton()
    func didTapIncorrectButton()
}

class WBInputControl: UIView {
    
    //properties
    var delegate:WBInputControlDelegate?
    var incorrectButton = UIButton()
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
        incorrectButton = UIButton.init(type: .custom)
        incorrectButton.setImage(#imageLiteral(resourceName: "red-button-normal"), for: .normal)
        incorrectButton.setImage(#imageLiteral(resourceName: "red-button-pressed"), for: .highlighted)
        incorrectButton.addStaticHeightConstraint(constant: 111)
        incorrectButton.addStaticWidthConstraint(constant: 111)
        incorrectButton.addTarget(self, action: #selector(self.didTapIncorrectButton), for: .touchUpInside)
        
        //incorrect button
        correctButton = UIButton.init(type: .custom)
        correctButton.setImage(#imageLiteral(resourceName: "green-button-normal"), for: .normal)
        correctButton.setImage(#imageLiteral(resourceName: "green-button-pressed"), for: .highlighted)
        correctButton.addStaticHeightConstraint(constant: 111)
        correctButton.addStaticWidthConstraint(constant: 111)
        correctButton.addTarget(self, action: #selector(self.didTapCorrectButton), for: .touchUpInside)
        
        //containerStackView
        containerStackView = UIStackView.init(arrangedSubviews: [incorrectButton, correctButton])
        self.addSubview(containerStackView)
        containerStackView.spacing = K.padding.side
        containerStackView.distribution = .fillEqually
        containerStackView.axis = .horizontal
        containerStackView.fillSuperView(UIEdgeInsets.init(top: K.padding.side, left: K.padding.side, bottom: K.padding.side+24.0, right: K.padding.side))
    }
    
    @objc func didTapCorrectButton() {
        NSLog("CorrectButton")
        delegate?.didTapCorrectButton()
        
    }
    
    @objc func didTapIncorrectButton() {
        NSLog("IncorrectButton")
        delegate?.didTapIncorrectButton()
    }
    
    //misc
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
