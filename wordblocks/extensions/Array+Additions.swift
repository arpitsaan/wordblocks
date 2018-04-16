//
//  Array+Additions.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 15/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//
import Foundation

extension Array {
    func random() -> Element {
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
}
