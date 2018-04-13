//
//  WBWordView.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 13/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class WBWordView: UIView {
    
    var wordLabel = UILabel()
    var containerView = UIView()
    var wordData:String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView() {
        //container
        containerView = UIView.init(frame: self.bounds)
        containerView.backgroundColor = WBColor.purple;
        
        //label
        wordLabel = UILabel.init(frame: self.bounds)
        wordLabel.font = UIFont(name: "DINAlternate-Bold", size: 24)
        wordLabel.textColor = .white
        wordLabel.textAlignment = .center
        
        //fitting label
        wordLabel.setContentHuggingPriority(.required, for: .horizontal)
        wordLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        wordLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        wordLabel.setContentHuggingPriority(.required, for: .vertical)
        
        //add views
        self.addSubview(containerView)
        self.addSubview(wordLabel)
        
        //constraints
        wordLabel.fillSuperView()
        containerView.fillSuperView()
    }
    
    func setWordData(wordData:String?) {
        self.wordLabel.text = wordData
    }
}
