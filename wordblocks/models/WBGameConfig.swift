//
//  WBGameConfig.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 15/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

enum WBGameConfig {
    case gravityFactor
    case matchingBias
    case scorePerWord
    case difficultyFactor  //% increase in gravity per turn
    
    var value: Double {
        switch self {
            //gravity increases by 10% in each turn
            case .gravityFactor: return 1.1
            case .difficultyFactor: return 1.1
            
            //33% probability of getting matched words
            case .matchingBias: return 0.33
            
            //1 score increase per correct ans
            case .scorePerWord: return 1
        }
    }
    
    var intValue: Int {
        switch self {
        case .difficultyFactor: return 1
        case .gravityFactor: return 1
        case .matchingBias: return 0
        case .scorePerWord: return 1
        }
    }
}
