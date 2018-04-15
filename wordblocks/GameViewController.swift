//
//  GameViewController.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 12/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, WBInputControlDelegate {
    
    //properties
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var currentState: WBGameState!
    
    var pauseControl = WBPauseControl()
    var livesView = WBLivesView()
    var topWordView = WBWordView()
    var bottomWordView = WBWordView()
    var inputControl = WBInputControl()
    var scoreView = WBScoreView()
    
    var didCollideOnce:Bool = false
    
    //selectors
    @objc func didTapScreen() {
        self.userDidTapScreen()
    }
    
    @objc func gameStateUpdated(notification: NSNotification){
        self.updateViewState()
    }

}


//-------------------------------
// MARK:  View Lifecycle + UI
//-------------------------------
extension GameViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForNotifications()
        self.createView()
        WBGameManager.beginGame()
    }

    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.gameStateUpdated),
            name: .gameManager,
            object: nil)
    }

    func createView() {
        //tap gesture
        let tapGesture = UITapGestureRecognizer.init(target: self, action:#selector(didTapScreen))
        self.view.addGestureRecognizer(tapGesture)
        
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
        
        //update layout
        self.view.layoutIfNeeded()
    }
}


//-------------------------------
// MARK:  Animation and Physics
//-------------------------------
extension GameViewController: UICollisionBehaviorDelegate {
    
    func startTurn() {
        
        //animation
        let itemBehaviour = UIDynamicItemBehavior(items: [topWordView, bottomWordView])
        itemBehaviour.elasticity = 0.1
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [topWordView])
        gravity.magnitude = 0.1
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [topWordView, bottomWordView])
        collision.collisionDelegate = self
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        if !self.didCollideOnce {
            self.didCollideOnce = true
            //            self.userIsWrong(byCollision: true) //asdf
        }
    }
}

//---------------------
// MARK: User Actions
//---------------------
extension GameViewController {
    
    func userDidTapScreen() {
        WBGameManager.updateTurn(action: .tapScreen)
    }
    
    func didTapCorrectButton() {
        WBGameManager.updateTurn(action: .tapTick)
    }
    
    func didTapIncorrectButton() {
        WBGameManager.updateTurn(action: .tapCross)
    }
    
}

//------------------------
// MARK: State Handlers
//------------------------
extension GameViewController {
    
//    case welcome
//    case start
//    case active
//    case pause
//    case won
//    case lost
//    case gameover
    
    func updateViewState() {
        switch WBGameManager.currentTurn.gameState {
            case .welcome:
                welcomeUser()
            
            case .start:
                startTurn()
            
            case .active:
                resumeTurn()
            
            case .pause:
                pauseGame()
            
            case .won:
                showWonView()
            
            case .lost:
                showLostView()
            
            case .gameover:
                gameOver()
        }
    }
    
    //welcome
    func welcomeUser() {
        
    }
    
    //resume
    func resumeTurn() {
    }
    
    //pause
    func pauseGame() {
        
    }
    
    //won
    func showWonView() {
        
    }
    
    //lost
    func showLostView() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.backgroundColor = WBColor.red
            self.inputControl.alpha = 0
            self.pauseControl.alpha = 0
            self.scoreView.alpha = 0
            self.livesView.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            self.livesView.setActiveLives(count: WBGameManager.currentTurn.activeLives)
        })
        //        if remainingLives <= 0 {
        //            //game over
        //            let alertController = UIAlertController.init(title: "Game over!", message: "Continue to a new game...", preferredStyle: UIAlertControllerStyle.alert);
        //            let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler:nil)
        //            alertController.addAction(action)
        //
        //            self.present(alertController, animated: true, completion: {
        //                self.resetScreen()
        //                //                CurrentTurnManager.sharedInstance.setRemainingLives(count: 3) //asdf reducer
        //                self.livesView.setActiveLives(count:WBGameManager.currentTurn.activeLives)
        //            })
        //        }
    }
    
    //gameover
    func gameOver() {
        
    }
    
    //reset
    func resetTurn() {
        
        if(self.animator != nil) {
            self.animator.removeAllBehaviors()
        }
        self.didCollideOnce = false
        
        self.view.backgroundColor = WBColor.textDarker
        self.inputControl.alpha = 1
        self.scoreView.alpha = 1
        self.pauseControl.alpha = 1
        self.livesView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        
        self.topWordView.transform = .identity
        self.bottomWordView.transform = .identity
        self.view.layoutIfNeeded()
    }
}


//---------------------
// MARK: Misc
//---------------------
extension GameViewController {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


