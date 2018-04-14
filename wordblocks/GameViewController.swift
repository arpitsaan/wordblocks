//
//  GameViewController.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 12/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, WBInputControlDelegate {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
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
        self.view.addSubview(scoreView)
        scoreView.addTrailingConstraint(toView: self.view, constant:-K.padding.side)
        scoreView.addTopConstraint(toView: self.view, constant:K.padding.side)
        scoreView.setTopScore(topScore: 140)
        scoreView.setCurrentScore(currentScore: 77)
        
        //input controls view
        inputControl = WBInputControl()
        inputControl.delegate = self
        self.view.addSubview(inputControl)
        self.inputControl.addLeadingConstraint(toView: self.view)
        self.inputControl.addTrailingConstraint(toView: self.view)
        self.inputControl.addBottomConstraint(toView: self.view)
        
        //top word
        topWordView = WBWordView.init()
        topWordView.setWordData(wordData: "headteacher")
        self.view.addSubview(topWordView)
        topWordView.addCenterXConstraint(toView: self.view)
        topWordView.addTopConstraint(toView: self.view, constant: 50)
        
        //bottom word
        bottomWordView = WBWordView.init()
        bottomWordView.setWordData(wordData: "director del colegio")
        self.view.addSubview(bottomWordView)
        bottomWordView.addCenterXConstraint(toView: self.view)
        bottomWordView.addBottomConstraint(toView: self.view, constant: -200)
        
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    func resetPositions() {
        self.animator.removeAllBehaviors()
        self.topWordView.transform = .identity
        self.bottomWordView.transform = .identity
        self.view.layoutIfNeeded()
    }
    
    func startAnimation() {
        //animation
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [topWordView])
        gravity.magnitude = 0.6
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [topWordView, bottomWordView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }
    
    //inputs
    func didTapCorrectButton() {
        self.startAnimation()
    }
    
    func didTapIncorrectButton() {
        self.resetPositions()
        self.view.layoutIfNeeded()
    }
}


