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
    var winLabel = UILabel()
    var loseLabel = UILabel()
    var crashedLabel = UILabel()
    
    var didCollideOnce:Bool = false
    var disableCollideAction:Bool = true
    
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
        Manager.beginGame()
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
        //self.view
        self.view.backgroundColor = getBGColor()
        
        //container view
        containerView = UIView.init()
        self.view.addSubview(containerView)
        containerView.fillSuperView()
        
        //tap gesture
        let tapGesture = UITapGestureRecognizer.init(target: self, action:#selector(didTapScreen))
        containerView.addGestureRecognizer(tapGesture)
        
        //collided label
        crashedLabel = UILabel.init()
        containerView.addSubview(crashedLabel)
        crashedLabel.font = UIFont(name: "DINAlternate-Bold", size: 20)
        crashedLabel.textColor = WBColor.bgDark
        crashedLabel.addCenterXConstraint(toView: containerView)
        crashedLabel.addCenterYConstraint(toView: containerView, constant: 50)
        crashedLabel.text = "💥CRASHED!💥 · Tap to continue…"
        crashedLabel.alpha = 0
        
        //win label
        winLabel = UILabel.init()
        containerView.addSubview(winLabel)
        winLabel.font = UIFont(name: "DINAlternate-Bold", size: 20)
        winLabel.textColor = WBColor.bgDark
        winLabel.addCenterXConstraint(toView: containerView)
        winLabel.addCenterYConstraint(toView: containerView, constant: 50)
        winLabel.text = "🙌 CORRECT · Tap to continue…"
        winLabel.alpha = 0
        
        //lose label
        loseLabel = UILabel.init()
        containerView.addSubview(loseLabel)
        loseLabel.font = UIFont(name: "DINAlternate-Bold", size: 20)
        loseLabel.textColor = WBColor.bgDark
        loseLabel.addCenterXConstraint(toView: containerView)
        loseLabel.addCenterYConstraint(toView: containerView, constant: 50)
        loseLabel.text = "💔 INCORRECT · Tap to continue…"
        loseLabel.alpha = 0
        
        //lives view
        livesView = WBLivesView()
        containerView.addSubview(livesView)
        livesView.layer.anchorPoint = CGPoint.init(x: 1.0, y: 0)
        self.livesView.addTrailingConstraint(toView: containerView, constant:-1)
        self.livesView.addTopConstraint(toView: containerView, constant:K.padding.side*2.5)
        
        //score card view
        scoreView = WBScoreView()
        containerView.addSubview(scoreView)
        scoreView.layer.anchorPoint = CGPoint.init(x: 0, y: 0)
        scoreView.addLeadingConstraint(toView: containerView, constant:K.padding.side)
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
        self.disableCollideAction = false
        self.didCollideOnce = false
        self.containerView.alpha = 1.0
        
        //---------------------------------------
        // FIXME: First run container animation
        //---------------------------------------
        //
        //
        //        if WBGameManager.previousTurn == nil {
        //            self.containerView.transform = CGAffineTransform.init(translationX: 0, y: -200)
        //            self.view.layoutIfNeeded()
        //            print("[WB]Completed")
        //
        //            UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
        //                self.containerView.alpha = 1.0
        //                self.containerView.transform = CGAffineTransform.identity
        //                self.view.layoutIfNeeded()
        //            }, completion: { (true) in
        //                print("[WB]Completed")
        //                self.view.layoutIfNeeded()
        //            })
        //
        //        }
        
        //populate word in the ui
        self.topWordView.setWordData(wordData: Manager.currentTurn.turnWord.topWordText)
        self.bottomWordView.setWordData(wordData: Manager.currentTurn.turnWord.bottomWordText)
        
        //setup animation physics
        let itemBehaviour = UIDynamicItemBehavior(items: [topWordView, bottomWordView])
        itemBehaviour.allowsRotation = true
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [topWordView])
        gravity.magnitude = CGFloat(Double(Manager.currentTurn.gravityPercent)/85.0)
        
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [topWordView, bottomWordView])
        collision.collisionDelegate = self
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }

    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        
        print("[WB] Collision!")
        if !self.didCollideOnce {
            self.didCollideOnce = true
            if self.disableCollideAction == false {
                Manager.updateTurn(action: .collision)
            }
        }
        
    }
}

//---------------------
// MARK: User Actions
//---------------------
extension GameViewController {
    
    func userDidTapScreen() {
        Manager.updateTurn(action: .tapScreen)
    }
    
    func didTapCorrectButton() {
        Manager.updateTurn(action: .tapTick)
    }
    
    func didTapIncorrectButton() {
        Manager.updateTurn(action: .tapCross)
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
        updateHUDdata()
        
        switch Manager.currentTurn.gameState {
            case .welcome:
                welcomeUser()
            
            case .start:
                startTurn()
            
            case .active:
                resumeTurn()
            
            case .won:
                handleWinState()
            
            case .lost:
                handleLoseState()
        
            case .collision:
                handleCollisionState()
            
            case .gameover:
                gameOver()
        }
    }
    
    //update HUD
    func updateHUDdata() {
        self.scoreView.setTopScore(topScore: Manager.highScore)
        self.scoreView.setCurrentScore(currentScore: Manager.currentTurn.score)
        self.livesView.setActiveLives(count: Manager.currentTurn.activeLives)
    }
    
    //welcome
    func welcomeUser() {
        self.winLabel.alpha = 0
        self.loseLabel.alpha = 0
        self.crashedLabel.alpha = 0
        
        disableCollideAction = false
        didCollideOnce = false
        
        self.containerView.alpha = 0.2
        
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
            HIGHSCORE : 🏆 \(Manager.highScore)
            LIVES : 💖 x 3
            ---------------------------------
            
            👊 Go beat that High Score!
            """,
            preferredStyle: .alert);
        
        let action = UIAlertAction(title: "🏁 Start Playing 🏁",
                                   style: .default,
                                   handler: {(alert: UIAlertAction!) in Manager.updateTurn(action: .tapStart)})
        
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
    func handleWinState() {
        self.disableCollideAction = true
        self.loseLabel.alpha = 0
        self.crashedLabel.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .allowUserInteraction, animations: {
            
            self.view.backgroundColor = WBColor.green
            self.inputControl.alpha = 0
            self.winLabel.alpha = 1
            self.scoreView.setTopScore(topScore: Manager.highScore)
            self.scoreView.setCurrentScore(currentScore: Manager.currentTurn.score)
            self.livesView.alpha = 0
            self.scoreView.transform = CGAffineTransform.init(scaleX: 4, y: 4)
        }) { (true) in
            print("[WB] Win state animation completed")
        }
    }
    
    //lost
    func handleLoseState() {
        self.disableCollideAction = true
        self.winLabel.alpha = 0
        self.crashedLabel.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .allowUserInteraction, animations: {
            self.view.backgroundColor = WBColor.red
            self.inputControl.alpha = 0
            self.scoreView.alpha = 0
            self.loseLabel.alpha = 1
            self.livesView.transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
        }) { (true) in
            print("[WB] Lose state animation completed")
        }
    }
    
    //collision
    func handleCollisionState() {
        self.disableCollideAction = true
        self.loseLabel.alpha = 0
        self.winLabel.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.1, options: .allowUserInteraction, animations: {
            self.view.backgroundColor = WBColor.red
            self.inputControl.alpha = 0
            self.scoreView.alpha = 0
            self.crashedLabel.alpha = 1
            self.livesView.transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
        }) { (true) in
            print("[WB] Collision state animation completed")
        }
    }
    
    //gameover
    func gameOver() {
        didCollideOnce = false
        disableCollideAction = false
        
        var titleText = "GAME OVER"
        var messageText = """
        
        💔💔💔
        
        You scored \(Manager.currentTurn.score)
        
        ---------------------------------
        HIGHSCORE : 🏆 \(Manager.highScore)
        ---------------------------------
        
        👊 Go beat that High Score!
        """
        
        //TODO:Convert high score text to emojis
        
        if Manager.currentTurn.score >= Manager.highScore
            && Manager.currentTurn.score != 0 {
            titleText = "GAME OVER"
            messageText = """
            💔💔💔
            
            
            🏆
            NEW HIGHSCORE
            👉 \(Manager.highScore) 👈

            🙌 🙌 🙌 🙌
            """
        }
        
        let alertController = UIAlertController.init(
            title: titleText,
            message: messageText,
            preferredStyle: .alert);
        
        let action = UIAlertAction(title: "🏁 Play Again 🏁",
                                   style: .default,
                                   handler: {(alert: UIAlertAction!) in
                                    Manager.updateTurn(action: .tapRestart)})
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: {
        })
    }
    
    //helper
    private func getBGColor() -> UIColor {
        return WBColor.bgDark
    }
    
    //reset
    func resetView() {
        
        if(self.animator != nil) {
            self.animator.removeAllBehaviors()
        }
        self.winLabel.alpha = 0
        self.loseLabel.alpha = 0
        self.crashedLabel.alpha = 0
        self.didCollideOnce = false
        self.disableCollideAction = false
        
        self.view.backgroundColor = getBGColor()
        self.inputControl.alpha = 1
        self.livesView.alpha = 1
        self.scoreView.alpha = 1
        self.livesView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.scoreView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        
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


