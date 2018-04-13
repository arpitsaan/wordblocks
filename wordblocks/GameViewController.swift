//
//  GameViewController.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 12/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var topWordView = WBWordView()
    var bottomWordView = WBWordView()
    var pauseControl = WBPauseControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = WBColor.textDarker
        
        //pause button
        pauseControl = WBPauseControl.init(frame: self.view.bounds)
        self.view.addSubview(pauseControl)
        pauseControl.addLeadingConstraint(toView: self.view)
        pauseControl.addTopConstraint(toView: self.view)
        
        //top word
        topWordView = WBWordView.init()
        topWordView.setWordData(wordData: "headteacher")
        self.view.addSubview(topWordView)
        
        //bottom word
        bottomWordView = WBWordView.init()
        bottomWordView.setWordData(wordData: "director del colegio / directora del colegio")
        self.view.addSubview(bottomWordView)
        
        //constraints
        topWordView.addCenterXConstraint(toView: self.view)
        topWordView.addTopConstraint(toView: self.view, constant: 100)
        
        bottomWordView.addCenterXConstraint(toView: self.view)
        bottomWordView.addBottomConstraint(toView: self.view, constant: -200)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true;
    }
}

