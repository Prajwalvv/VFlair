//
//  SettingTableViewController.swift
//  vFlair
//
//  Created by splash on 25/04/19.
//  Copyright © 2019 fluid. All rights reserved.
//

import UIKit
import RAMPaperSwitch
class SettingTableViewController: UITableViewController {
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var switch1: RAMPaperSwitch!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var switch2: RAMPaperSwitch!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var switch3: RAMPaperSwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.setupPaperSwitch()
    }
     func setupPaperSwitch() {
        self.switch1.animationDidStartClosure = {(onAnimation: Bool) in
            
        self.animateLabel(self.title1, onAnimation: onAnimation, duration: self.switch1.duration)
        
    }
    
    
    self.switch2.animationDidStartClosure = {(onAnimation: Bool) in
    
    self.animateLabel2(self.self.title2, onAnimation: onAnimation, duration: self.switch2.duration)
    
    }
    
    self.switch3.animationDidStartClosure = {(onAnimation: Bool) in
    
    self.animateLabel3(self.self.title3, onAnimation: onAnimation, duration: self.switch3.duration)
    
    }

    }
    func animateLabel(_ label: UILabel, onAnimation: Bool, duration: TimeInterval) {
        UIView.transition(with: label, duration: duration, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            label.textColor = onAnimation ? UIColor.white : UIColor .orange
        }, completion:nil)
    }
    func animateLabel2(_ label: UILabel, onAnimation: Bool, duration: TimeInterval) {
        UIView.transition(with: label, duration: duration, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            label.textColor = onAnimation ? UIColor.white : UIColor .orange
        }, completion:nil)
    }
    func animateLabel3(_ label: UILabel, onAnimation: Bool, duration: TimeInterval) {
        UIView.transition(with: label, duration: duration, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            label.textColor = onAnimation ? UIColor.white : UIColor .orange
        }, completion:nil)
    }

}
