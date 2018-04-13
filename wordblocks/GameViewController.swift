//
//  GameViewController.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 12/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var pauseControl = WBPauseControl()
    var livesView = WBLivesView()
    var topWordView = WBWordView()
    var bottomWordView = WBWordView()
    var inputControl = WBInputControl()
    var scoreView = WBScoreView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = WBColor.textDarker
        
        //pause button
        pauseControl = WBPauseControl.init(frame: self.view.bounds)
        self.view.addSubview(pauseControl)
        pauseControl.addLeadingConstraint(toView: self.view, constant: K.padding.side)
        pauseControl.addTopConstraint(toView: self.view, constant: K.padding.side)
        
        //lives view
        livesView = WBLivesView()
        self.view.addSubview(livesView)
        self.livesView.addCenterXConstraint(toView: self.view)
        self.livesView.addTopConstraint(toView: self.view, constant:K.padding.side+10.0)
        
        //score card view
        scoreView = WBScoreView()
        self.view.addSubview(livesView)
        self.livesView.addTrailingConstraint(toView: self.view, constant:K.padding.side)
        self.livesView.addTopConstraint(toView: self.view, constant:K.padding.side)
        
        //input controls view
        inputControl = WBInputControl()
        self.view.addSubview(inputControl)
        self.inputControl.addLeadingConstraint(toView: self.view)
        self.inputControl.addTrailingConstraint(toView: self.view)
        self.inputControl.addBottomConstraint(toView: self.view)
        
        //top word
        topWordView = WBWordView.init()
        topWordView.setWordData(wordData: "headteacher")
        self.view.addSubview(topWordView)
        topWordView.addCenterXConstraint(toView: self.view)
        topWordView.addBottomConstraint(toView: self.view, constant: -250)
        
        //bottom word
        bottomWordView = WBWordView.init()
        bottomWordView.setWordData(wordData: "director del colegio / directora del colegio")
        self.view.addSubview(bottomWordView)
        bottomWordView.addCenterXConstraint(toView: self.view)
        bottomWordView.addBottomConstraint(toView: self.view, constant: -200)
        
        //animation
        self.topWordView.transform.translatedBy(x: 0, y: -1000)
        self.view.layoutIfNeeded()
        animateTopWord()
    }
    
    func animateTopWord() {
        UIView.animate(withDuration: 10.0, animations: {
            self.topWordView.transform.translatedBy(x: 0, y: 0)
        }, completion: { finished in
            NSLog("Finished animating")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true;
    }
}

