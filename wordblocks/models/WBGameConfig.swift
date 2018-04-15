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
    
    var value: Double {
        switch self {
            case .gravityFactor: return 1.1
            case .matchingBias: return 0.33
        }
    }
}
