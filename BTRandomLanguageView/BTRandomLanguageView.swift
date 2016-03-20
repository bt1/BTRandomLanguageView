//
//  LanguageFadeAnimation.swift
//  Translate Bot
//
//  Created by benny on 3/20/16.
//  Copyright © 2016 squarevibe. All rights reserved.
//

import UIKit

class BTRandomLanguageView: UIView {
    
    let languageArray = ["hello", "Hola", "مرحبا", "你好", "হ্যালো", "Hallo", "hej","Përshëndetje", "Բարեւ", "Χαίρετε", "aloha", "שלום", "Dia dhuit", "Ciao", "こんにちは", "안녕하세요", "سلام", "cześć", "Olá", "Merhaba", "xin chào chào"]
    var view = UIView()
    var nibName = "LanguageFade"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        // setup the view from .xib
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        let label1 = UILabel(frame: CGRectMake(0, 0, 200, 21))
        let label2 = UILabel(frame: CGRectMake(0, 0, 200, 21))
        let label3 = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label1.textColor = UIColor.lightGrayColor()
        label2.textColor = UIColor.lightGrayColor()
        label3.textColor = UIColor.lightGrayColor()
        self.generateRandomLabel(label1)
        self.generateRandomLabel(label2)
        self.generateRandomLabel(label3)
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        // grabs the appropriate bundle
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    func generateRandomLabel(label: UILabel) {
        let randomItem = languageArray[Int(arc4random_uniform(UInt32(languageArray.count)))]
        //label.center = self.view.center
        label.text = randomItem
        getRandomPosition(label)
        view.addSubview(label)
        
        UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            label.alpha = 1.0
            
            }, completion: { (finished: Bool) -> Void in
                self.removeRandomLabel(label)
        })
        
    }
    
    func getRandomPosition(label: UILabel){
        // Get label width and height
        let labelWidth = label.frame.width
        let labelHeight = label.frame.height

        // Get view width and height
        let viewWidth = self.view.bounds.width
        let viewHeight = self.view.bounds.height
        
        // Get total space
        let xwidth = viewWidth - labelWidth
        let yheight = viewHeight - labelHeight
        
        // Randomly generate a x and y offset
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight/2 - 100)) + UInt32(yheight/2 + 120))
        
        label.center.x = xoffset + labelWidth
        label.center.y = yoffset + labelHeight
        label.alpha = 0
        print("\(label.center.x), \(label.center.y)")
    }
    
    func removeRandomLabel(label: UILabel) {
        UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            label.alpha = 0.0
            
            }, completion: { (finished: Bool) -> Void in
                
                // you can do this in a shorter, more concise way by setting the value to its opposite, NOT value
                //self.removeRandomLabel(label)
                self.generateRandomLabel(label)
        })
    }
    
}
