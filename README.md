👋Hi! Welcome to the Word Blocks Page.
[Read design process on the Medium Blog](https://medium.com/@agarwalarpit/building-an-ios-game-with-9-steps-of-design-and-9-steps-of-programming-in-24-hours-397a048fe957)

![Word Blocks - Game in Action](/images/start.PNG?raw=true "Game Start!")

# What is Word Blocks?
World Blocks is an iPhone game to learn Spanish (if you already know English). 
Track your learning progress by a high score! It's super easy to play.


Coded with ❤️in the heart of India.


[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)  
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

## Gameplay
The goal of playing Word Blocks is to reach the highest possible score. 
The higher you score, the more you learn the language automatically!

When the game start, you will see a Spanish word on your screen. An English word block will fall from the top. 
You have to answer if these words mean the SAME ✅ or NOT ❌

For every correct answer, you get +1🙌 in your score. 

For every incorrect answer, you lose a life -❤️. 

The game starts with you having 3 lives, the game ends when you lose all lives.

🔥It becomes challenging over time as the the gravity in the scene increases with every correct answer.

![](header.png)


## Installation
Clone this repository ->  Hit run in your XCode -> Start Playing!

## Unit Testing
- Word Blocks has a **wordblocksTests** target automatically test the Gameplay Manager.
- Testing this module can exhaustively test all possible scenarios of the Gameplay.

## UI Testing
- The **wordblocksUITests** target automatically does a Smoke Test for the Game.
- It starts the game and simulates touches for the first 6 turns as a user.
- If the usability of the Game UI is broken, this test will fail.

## Design
You can read about the design in this Medium article:
https://medium.com/@agarwalarpit/building-an-ios-game-with-9-steps-of-design-and-9-steps-of-programming-in-24-hours-397a048fe957

## Engineering
Word Blocks has single source of truth for the views in the whole app. I architected the views to be reactive to the data model. A notification is fired to update all the views whenever the data model has been updated. This makes the data flow unidirectional to the Views — somewhat similar to how React works. 

- All data for the current turn is saved in a `WBTurn` object
`   var score:Int
    var activeLives:Int
    var turnWord:WBTurnWord
    var gravityPercent:Int
    var gameState:WBGameState 
    `

- The user can perform the following actions during the Gameplay
`   case tapStart
    case tapResume
    case tapRestart
    case tapTick
    case tapCross
    case tapScreen
    case collision //when no user action
    `

- The game is always in one of the following states 

`   case start
    case active
    case won
    case lost
    case collision
    case gameover
    `
    
- A Manager class runs the whole gameplay
`
    public static func updateTurn(action:WBUserAction)

`
This gameplay runs on a state machine. Depending on the user action provided to this method, the current game state jumps to a new state with an updated data model. Since there is a persistent single source of truth for data in the whole app, everything remains in sync.
    

## Time Invested
- Concept : Word Blocks took 3.5 hours to design, with the document.
- Game Mechanics : Took 1 hour to architect a State Machine for the whole game.
- Model Layer : 2 Hours, with the architure of the word.
- Views : 3 Hours including gravity animation.
- Automated Tests : 1 hour for UI Smoke test and unit tests on the gameplay.

## Meta

Arpit Agarwal – [@YourTwitter](https://twitter.com/dbader_org) – YourEmail@example.com

Distributed under the Apache license. See ``LICENSE`` for more information.

[https://github.com/arpitsaan/wordblocks](https://github.com/arpitsaan/)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-Apache-blue.svg
[license-url]: LICENSE
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
