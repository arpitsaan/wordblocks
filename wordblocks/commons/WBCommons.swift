//
//  WBCommons.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 13/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class WBCommons: NSObject {
    static func screenWidth() -> CGFloat {
        let screenSize = UIScreen.main.bounds
        return screenSize.width
    }
    
    static func screenHeight() -> CGFloat {
        let screenSize = UIScreen.main.bounds
        return screenSize.height
    }
}
