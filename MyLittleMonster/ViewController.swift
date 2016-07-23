//
//  ViewController.swift
//  MyLittleMonster
//
//  Created by Preeti Patel on 22/07/16.
//  Copyright © 2016 Vandan Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var monsterImage: UIImageView!
    
    @IBOutlet weak var heartImage: DragImage!
    
    @IBOutlet weak var foodImage: DragImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageArray = [UIImage]()
        
        for i in 1...4 {
            let img = UIImage(named: "idle_\(i).png")
            imageArray.append(img!)
        }
        
        monsterImage.animationImages = imageArray
        monsterImage.animationDuration = 0.8
        monsterImage.animationRepeatCount = 0
        monsterImage.startAnimating()
    }
}

