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
        
        //top score label
        topScoreLabel = UILabel.init()
        topScoreLabel.font = UIFont(name: "DINCondensed-Bold ", size: 18)
        topScoreLabel.textColor = WBColor.textDarker
        topScoreLabel.textAlignment = .center
        topScoreLabel.setContentHuggingPriority(.required, for: .horizontal)
        topScoreLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        topScoreLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        topScoreLabel.setContentHuggingPriority(.required, for: .vertical)
        
        topScoreLabel.layer.cornerRadius = 4.0
        topScoreLabel.clipsToBounds = true
        
        //container view
        self.containerStackView.addArrangedSubview(topScoreLabel)
        self.containerStackView.addArrangedSubview(currentScoreLabel)
        self.addSubview(containerStackView)
        containerStackView.spacing = 0
        containerStackView.distribution = .fill
        containerStackView.axis = .vertical
        
        containerStackView.fillSuperView()
    }
    
    //setters
    func setCurrentScore(currentScore: Int) {
        self.currentScoreLabel.text = String.init(format: "%@", currentScore)
    }
    
    func setTopScore(topScore: Int) {
        self.topScoreLabel.text = String.init(format: "   TOP %@   ", topScore)
    }
    
    //misc
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
