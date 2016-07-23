//
//  MonsterAnimation.swift
//  MyLittleMonster
//
//  Created by Preeti Patel on 23/07/16.
//  Copyright © 2016 Vandan Patel. All rights reserved.
//

import Foundation
import UIKit

class MonsterAnimation: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playMonsterAnimation()
    }
    
    func playMonsterAnimation() {
        
        self.image = UIImage(named: "idle_1.png")
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        
        for i in 1...4 {
            let img = UIImage(named: "idle_\(i).png")
            imageArray.append(img!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playMonsterDeathAnimation() {
        
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        
        for i in 1...5 {
            let img = UIImage(named: "dead\(i).png")
            imageArray.append(img!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
}

