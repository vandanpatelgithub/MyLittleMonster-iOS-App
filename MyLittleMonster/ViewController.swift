//
//  ViewController.swift
//  MyLittleMonster
//
//  Created by Preeti Patel on 22/07/16.
//  Copyright © 2016 Vandan Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var skulImg1: UIImageView!
    
    @IBOutlet weak var skulImg2: UIImageView!
    
    @IBOutlet weak var skulImg3: UIImageView!
    
    @IBOutlet weak var monsterImage: MonsterAnimation!
    
    @IBOutlet weak var heartImage: DragImage!
    
    @IBOutlet weak var foodImage: DragImage!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monsterSurviving = false
    var currentItem: UInt32 = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImage.dropTarget = monsterImage
        heartImage.dropTarget = monsterImage
        
        skulImg1.alpha = DIM_ALPHA
        skulImg2.alpha = DIM_ALPHA
        skulImg3.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        startTimer()
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterSurviving = true
        startTimer()
        
        foodImage.alpha = DIM_ALPHA
        foodImage.userInteractionEnabled = false
        
        heartImage.alpha = DIM_ALPHA
        heartImage.userInteractionEnabled = false
        
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterSurviving {
            penalties += 1
            
            if penalties == 1 {
                skulImg1.alpha = OPAQUE
                skulImg2.alpha = DIM_ALPHA
                skulImg3.alpha = DIM_ALPHA
            }
            else if penalties == 2 {
                skulImg2.alpha = OPAQUE
                skulImg1.alpha = OPAQUE
                skulImg3.alpha = DIM_ALPHA
            }
            else if penalties >= 3 {
                skulImg1.alpha = OPAQUE
                skulImg2.alpha = OPAQUE
                skulImg3.alpha = OPAQUE
            }
            else {
                skulImg1.alpha = DIM_ALPHA
                skulImg2.alpha = DIM_ALPHA
                skulImg3.alpha = DIM_ALPHA
            }
            
            if penalties >= MAX_PENALTIES {
                gameOver()
            }
        }
        
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            foodImage.alpha = DIM_ALPHA
            foodImage.userInteractionEnabled = false
            
            heartImage.alpha = OPAQUE
            heartImage.userInteractionEnabled = true
        }
        else {
            heartImage.alpha = DIM_ALPHA
            heartImage.userInteractionEnabled = false
            
            foodImage.alpha = OPAQUE
            foodImage.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterSurviving = false
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImage.playMonsterDeathAnimation()
    }
}

