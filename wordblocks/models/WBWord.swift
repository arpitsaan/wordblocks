//
//  WBWord.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 15/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

struct WBWord {
    var en:String
    var es:String
    
    var isDone:Bool
    
    init(
        en:String = "",
        es:String = "",
        isDone:Bool = false) {
        self.en = en
        self.es = es
        self.isDone = isDone
    }
}
