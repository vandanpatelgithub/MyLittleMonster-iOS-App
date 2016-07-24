//
//  ViewController.swift
//  MyLittleMonster
//
//  Created by Preeti Patel on 22/07/16.
//  Copyright © 2016 Vandan Patel. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImage.dropTarget = monsterImage
        heartImage.dropTarget = monsterImage
        
        skulImg1.alpha = DIM_ALPHA
        skulImg2.alpha = DIM_ALPHA
        skulImg3.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:
                NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:
                NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:
                NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:
                NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:
                NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        startTimer()
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterSurviving = true
        startTimer()
        
        foodImage.alpha = DIM_ALPHA
        foodImage.userInteractionEnabled = false
        
        heartImage.alpha = DIM_ALPHA
        heartImage.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
        
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
            
            sfxSkull.play()
            
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
        sfxDeath.play()
    }
}

