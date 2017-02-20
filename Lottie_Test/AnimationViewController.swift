//
//  AnimationViewController.swift
//  Lottie_Test
//
//  Created by Tim Beals on 2017-02-19.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import Lottie

class AnimationViewController: UIViewController {

    var playAnimationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("Play Animation", for: .normal)
        button.addTarget(self, action: #selector(playAnimation), for: .touchUpInside)
        return button
    }()
    
    var animationView: LOTAnimationView = {
        let view = LOTAnimationView.animationNamed("pin_jump")
        view?.backgroundColor = UIColor.white
        view?.loopAnimation = true
        view?.contentMode = .scaleAspectFill
        return view!
    }()
    
    var menuOn: Bool = true
    var morphButton: LOTAnimationView?
    lazy var morphFrame: CGRect = {
        return CGRect(x: (self.view.frame.size.width - 75) / 2, y: CGFloat(350), width: CGFloat(75), height: CGFloat(75))
    }()
    
    func addMorphButton(on: Bool) {
        if (morphButton != nil) {
            morphButton?.removeFromSuperview()
            morphButton = nil
        }
        
        let animation = on ? "button_on" : "button_off"
        
        morphButton = LOTAnimationView.animationNamed(animation)
        morphButton?.frame = morphFrame
        morphButton?.isUserInteractionEnabled = true
        morphButton?.contentMode = .scaleAspectFill

        addGestureToMorphButton()
        
        self.view.addSubview(morphButton!)
    }

    
    //add gesture recognizer
    func addGestureToMorphButton() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.playButtonAnimation(recognizer:)))
        tapRecognizer.numberOfTapsRequired = 1
        morphButton?.addGestureRecognizer(tapRecognizer)
    }
    
    
    //play animation
    func playButtonAnimation(recognizer: UITapGestureRecognizer) {
        if menuOn {
            morphButton?.play(completion: { (success) in
                self.menuOn = false
                self.addMorphButton(on: self.menuOn)
            })
        } else {
            morphButton?.play(completion: { (success) in
                self.menuOn = true
                self.addMorphButton(on: self.menuOn)
            })

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Animation"
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(playAnimationButton)
        playAnimationButton.frame = CGRect(x: 16, y: Int(view.frame.height - 200), width: Int(view.frame.width - 32), height: 30)
        
        view.addSubview(animationView)
        animationView.frame = CGRect(x: 0, y: 70, width: Int(view.frame.width), height: Int(view.frame.width * 0.5625))
        
        addMorphButton(on: menuOn)
    }

    func playAnimation() {
        print("button pressed")
        
        if animationView.isAnimationPlaying {
            animationView.pause()
        } else {
            animationView.play()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
