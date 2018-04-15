//
//  WBScoreView.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 14/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class WBScoreView: UIView {

    //properties
    var currentScoreLabel = UILabel()
    var topScoreLabel = UILabel()
    var topScoreBgView = UIView()
    var containerStackView = UIStackView()
    
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    //ui
    private func createView() {
        //current score label
        currentScoreLabel = UILabel.init()
        currentScoreLabel.font = UIFont(name: "DINAlternate-Bold", size: 50)
        currentScoreLabel.textColor = WBColor.yellow
        currentScoreLabel.textAlignment = .center
        
        currentScoreLabel.setContentHuggingPriority(.required, for: .horizontal)
        currentScoreLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        currentScoreLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        currentScoreLabel.setContentHuggingPriority(.required, for: .vertical)
        
        //top score label bg
        topScoreBgView = UIView()
        topScoreBgView.backgroundColor = WBColor.green
        topScoreBgView.addStaticHeightConstraint(constant: 18)
        topScoreBgView.addStaticWidthConstraint(constant: 46)
        topScoreBgView.layer.cornerRadius = 2.0
        topScoreBgView.clipsToBounds = true
        
        //top score label
        topScoreLabel = UILabel.init()
        topScoreLabel.textAlignment = .center
        topScoreLabel.font = UIFont(name: "DINCondensed-Bold", size: 17)
        topScoreLabel.textColor = WBColor.textDarker
        topScoreLabel.adjustsFontSizeToFitWidth = true
        topScoreLabel.minimumScaleFactor = 0.7
        topScoreLabel.setContentHuggingPriority(.required, for: .horizontal)
        topScoreLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        topScoreLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        topScoreLabel.setContentHuggingPriority(.required, for: .vertical)
        topScoreBgView.addSubview(topScoreLabel)
        topScoreLabel.addCenterXConstraint(toView: topScoreBgView)
        topScoreLabel.addCenterYConstraint(toView: topScoreBgView, constant: 3.0)
        
        //container view
        self.containerStackView.addArrangedSubview(topScoreBgView)
        self.containerStackView.addArrangedSubview(currentScoreLabel)
        self.addSubview(containerStackView)
        containerStackView.spacing = -6
        containerStackView.distribution = .fillProportionally
        containerStackView.axis = .vertical
        
        containerStackView.fillSuperView()
    }
    
    //setters
    func setCurrentScore(currentScore: Int) {
        self.currentScoreLabel.text = String(currentScore)
    }
    
    func setTopScore(topScore: Int) {
        let scoreText = String(topScore)
        self.topScoreLabel.text = "HIGH \(scoreText)"
    }
    
    //misc
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
