//
//  GameViewController.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 12/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

//---------------------------------------
// MARK: Main Controller + Property List
//---------------------------------------
class GameViewController: UIViewController, WBInputControlDelegate {
    //properties
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var currentState: WBGameState!
    
    var containerView = UIView()
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        //container view
        containerView = UIView.init()
        self.view.addSubview(containerView)
        containerView.fillSuperView()
        
        //tap gesture
        let tapGesture = UITapGestureRecognizer.init(target: self, action:#selector(didTapScreen))
        containerView.addGestureRecognizer(tapGesture)
        
        //lives view
        livesView = WBLivesView()
        containerView.addSubview(livesView)
        self.livesView.addCenterXConstraint(toView: containerView)
        self.livesView.addTopConstraint(toView: containerView, constant:K.padding.side+10.0)
        
        //score card view
        scoreView = WBScoreView()
        containerView.addSubview(scoreView)
        scoreView.addTrailingConstraint(toView: containerView, constant:-K.padding.side)
        scoreView.addTopConstraint(toView: containerView, constant:K.padding.side)
        scoreView.setTopScore(topScore: 140)
        scoreView.setCurrentScore(currentScore: 77)
        
        //top word
        topWordView = WBWordView.init()
        containerView.addSubview(topWordView)
        topWordView.addCenterXConstraint(toView: containerView)
        topWordView.addTopConstraint(toView: containerView, constant:0)
        
        //bottom word
        bottomWordView = WBWordView.init()
        containerView.addSubview(bottomWordView)
        bottomWordView.addCenterXConstraint(toView: containerView)
        bottomWordView.addBottomConstraint(toView: containerView, constant: -200)
        
        //input controls view
        inputControl = WBInputControl()
        inputControl.delegate = self
        containerView.addSubview(inputControl)
        self.inputControl.addLeadingConstraint(toView: containerView)
        self.inputControl.addTrailingConstraint(toView: containerView)
        self.inputControl.addBottomConstraint(toView: containerView)
        
        //update layout
        self.view.layoutIfNeeded()
    }
}


//-------------------------------
// MARK:  Animation and Physics
//-------------------------------
extension GameViewController: UICollisionBehaviorDelegate {
    
    func startTurn() {
        self.containerView.alpha = 1.0
        
        //word
        self.topWordView.setWordData(wordData: WBGameManager.currentTurn.turnWord.topWordText)
        self.bottomWordView.setWordData(wordData: WBGameManager.currentTurn.turnWord.bottomWordText)
        
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
            WBGameManager.updateTurn(action: .collision)
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
    
    //-------------
    // Game States
    //-------------
    //welcome
    //start
    //active
    //won
    //lost
    //gameover
    
    func updateViewState() {
        switch WBGameManager.currentTurn.gameState {
            case .welcome:
                welcomeUser()
            
            case .start:
                startTurn()
            
            case .active:
                resumeTurn()
            
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
        self.containerView.alpha = 0.1
        
        let alertController = UIAlertController.init(
            title: "Welcome to Word Blocks!",
            message: """
            You will see a word, and a word in another language will start falling
            
            💥 Answer before they collide 💥
            
            Tap ✅ if words mean the same
            Tap ❌ if they mean different
            
            👏 Score points with correct answer!
            💔 You'll lose a life for every error
            
            ---------------------------------
            HIGHSCORE : 🏆 \(WBGameManager.highScore)
            LIVES : 💖 x 3
            ---------------------------------
            
            👊 Go beat that High Score!
            """,
            preferredStyle: .alert);
        
        let action = UIAlertAction(title: "🏁 Start Playing 🏁",
                                   style: .default,
                                   handler: {(alert: UIAlertAction!) in WBGameManager.updateTurn(action: .tapStart)})
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: {
        })
    }
    
    //resume
    func resumeTurn() {
        resetView()
        startTurn()
    }
    
    //won
    func showWonView() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.backgroundColor = WBColor.green
            self.inputControl.alpha = 0
            self.scoreView.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            self.livesView.alpha = 0
            self.livesView.setActiveLives(count: WBGameManager.currentTurn.activeLives)
            self.scoreView.setTopScore(topScore: WBGameManager.highScore)
            self.scoreView.setCurrentScore(currentScore: WBGameManager.currentTurn.score)
        })
    }
    
    //lost
    func showLostView() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.backgroundColor = WBColor.red
            self.inputControl.alpha = 0
            self.scoreView.alpha = 0
            self.livesView.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            self.livesView.setActiveLives(count: WBGameManager.currentTurn.activeLives)
        })
    }
    
    //gameover
    func gameOver() {
        
        let alertController = UIAlertController.init(title: "Game over!", message: "Continue to a new game...", preferredStyle: UIAlertControllerStyle.alert);
        let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler:nil)
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: {
        })
    }
    
    //reset
    func resetView() {
        
        if(self.animator != nil) {
            self.animator.removeAllBehaviors()
        }
        
        self.didCollideOnce = false
        
        self.view.backgroundColor = WBColor.textDarker
        self.inputControl.alpha = 1
        self.scoreView.alpha = 1
        self.livesView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        
        self.topWordView.topAnchor.constraint(equalTo: self.topWordView.topAnchor, constant: 0).isActive = true
        self.bottomWordView.bottomAnchor.constraint(equalTo: self.bottomWordView.bottomAnchor, constant: -200).isActive = true
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


