//
//  IMPulseButton.swift
//
//
//  Created by isa on 16.10.2020.
//  Copyright © 2020 isamercan. All rights reserved.
//

import UIKit

@IBDesignable
class IMPulseButton: UIButton {
    
    // MARK: Public properties
    private var timer: Timer!
    
    var gradient: CAGradientLayer?
    
    var pulseButtonAnimation = CASpringAnimation(keyPath: "transform.scale")
    
    var pulseAnimation : PulseLayerAnimation?
    
    //MARK: - Action Closure
    private var action: (() -> Void)?
    
    //MARK: - Inspactable variables
    @IBInspectable var buttonTitle: String = "My Button" {
        didSet {
            setupTitle()
        }
    }
    
    @IBInspectable var buttonTitleColor: UIColor = UIColor.white {
        didSet {
            setupTitle()
        }
    }
    
    @IBInspectable var buttonTitleFont: UIFont = .boldSystemFont(ofSize: 19.0) {
        didSet {
            setupTitle()
        }
    }
    
    @IBInspectable var buttonBackgroundColor : UIColor = UIColor.blue {
        didSet{
            self.layer.backgroundColor = buttonBackgroundColor.cgColor
        }
    }
    
    @IBInspectable public var fullyRoundedCorners: Bool = false {
        didSet{
            setupCorners()
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
            if let gradientLayer = gradient {
                gradientLayer.cornerRadius = cornerRadius
            }
        }
    }
    
    //MARK: - Gradient Background
    @IBInspectable open var gradientEnabled: Bool = false{
        didSet{
            setupGradient()
        }
    }
    
    @IBInspectable open var gradientStartColor: UIColor = UIColor.clear{
        didSet{
            setupGradient()
        }
    }
    
    @IBInspectable open var gradientEndColor: UIColor = UIColor.clear{
        didSet{
            setupGradient()
        }
    }
    
    @IBInspectable open var gradientHorizontal: Bool = false{
        didSet{
            setupGradient()
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var pulseAnimationEnabled: Bool = false {
        didSet{
            playAnimations()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //MARK: - Interface Builder Methods
    override open func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
}

//MARK: IMPulseButton Base Init
extension IMPulseButton {
    func commonInit(title: String,
                            fullRounded: Bool = true,
                            animationEnabled: Bool = true,
                            action: @escaping () -> Void){
        self.buttonTitle = title
        self.fullyRoundedCorners = fullRounded
        self.pulseAnimationEnabled = animationEnabled
        self.action = action
    }
    
}

//MARK: IMPulseButton Set interface functions
extension IMPulseButton {
    // Setup the UIButton appearance
    fileprivate func setupView(){
        layer.masksToBounds = false
        gradient?.frame = layer.bounds
        
        playAnimations()
        
        setupCorners()
        
        addTargets()
    }
    
    private func setupTitle(){
        self.setTitle(buttonTitle, for: .normal)
        self.setTitleColor(buttonTitleColor, for: .normal)
        self.titleLabel?.font = buttonTitleFont
    }
    
    private func setupGradient(){
        gradient?.removeFromSuperlayer()
        
        guard gradientEnabled != false else{
            return
        }
        
        gradient = CAGradientLayer()
        guard let gradient = gradient else { return }
        
        gradient.frame = layer.bounds
        gradient.colors = [gradientStartColor.cgColor, gradientEndColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = gradientHorizontal ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 1)
        gradient.cornerRadius = layer.cornerRadius
        
        self.layer.insertSublayer(gradient, at: 1)
    }
    //    MARK: Setup corner radious
    fileprivate func setupCorners() {
        if fullyRoundedCorners {
            layer.cornerRadius = layer.frame.size.height/2
            gradient?.cornerRadius = layer.frame.size.height/2
            pulseAnimation?.cornerRadius = layer.frame.size.height/2*1.5
        }else{
            layer.cornerRadius = cornerRadius
            gradient?.cornerRadius = cornerRadius
            pulseAnimation?.cornerRadius = cornerRadius
        }
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
}


//MARK: IMPulseButton Clouseres and Targets
extension IMPulseButton {
    //    MARK: ADD Targets
    fileprivate func addTargets() {
        self.addTarget(self, action: #selector(IMPulseButton.touchDown(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(IMPulseButton.doAction), for: .touchUpInside)
        self.addTarget(self, action: #selector(IMPulseButton.touchUpInside), for: .touchUpInside)
        self.addTarget(self, action: #selector(IMPulseButton.touchDragExit(_:)), for: .touchDragExit)
        self.addTarget(self, action: #selector(IMPulseButton.touchDragEnter(_:)), for: .touchDragEnter)
        self.addTarget(self, action: #selector(IMPulseButton.touchCancel(_:)), for: .touchCancel)
    }
    
    func IMPulseButtonTapped(action: @escaping () -> Void) {
        self.action = action
        self.addTarget(self, action: #selector(IMPulseButton.doAction), for: .touchUpInside)
    }
    
    @objc func doAction() {
        action?()
    }
    
    @objc func touchDown(_ sender: IMPulseButton) {
        self.layer.opacity = 0.4
    }
    
    @objc func touchUpInside(_ sender: IMPulseButton) {
        resetTimer()
        self.layer.opacity = 1.0
    }
    
    @objc func touchDragExit(_ sender: IMPulseButton) {
        self.layer.opacity = 1.0
    }
    
    @objc func touchDragEnter(_ sender: IMPulseButton) {
        self.layer.opacity = 0.4
    }
    @objc func touchCancel(_ sender: IMPulseButton) {
        self.layer.opacity = 1.0
    }
}

//MARK: IMPulseButton Animations
extension IMPulseButton {
    fileprivate func playAnimations() {
        
        guard pulseAnimationEnabled != false else {
               return
        }
        scheduledTimerWithTimeInterval()
    }
    
    private func scheduledTimerWithTimeInterval(){
        IMPulseButtonAnimation()
        IMPulseButtonLayerAnimation()
        
        //Kill the timer
        timer?.invalidate()
        
        //Start Timer
        timer = Timer.scheduledTimer(timeInterval: 2.4, target: self, selector: #selector(self.IMPulseButtonAnimation), userInfo: nil, repeats: true)
    }
    
    @objc func IMPulseButtonAnimation() {
        pulseButtonAnimation.duration = 0.6
        pulseButtonAnimation.fromValue = 1.0
        pulseButtonAnimation.toValue = 1.05
        pulseButtonAnimation.autoreverses = false
        pulseButtonAnimation.repeatCount = 1
        pulseButtonAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulseButtonAnimation.initialVelocity = 1
        pulseButtonAnimation.damping = 0.8
        layer.add(pulseButtonAnimation, forKey: "pulsingButton")
    }
    
    @objc func IMPulseButtonLayerAnimation(){
        pulseAnimation?.removeFromSuperlayer()
        
        let pulseWidth: CGFloat = layer.bounds.width*1.15
        let pulseHeight: CGFloat = layer.bounds.height*1.4
        
        if pulseAnimation != nil {
            pulseAnimation?.removeFromSuperlayer()
            pulseAnimation?.removeAllAnimations()
        }
        
        pulseAnimation = PulseLayerAnimation(numberOfPulse: Float.infinity,
                                             radius: layer.cornerRadius,
                                             postion: CGPoint(x: layer.frame.width / 2, y: layer.frame.height / 2),
                                             width: pulseWidth, height: pulseHeight)
        
        pulseAnimation?.animationDuration = 1.5
        pulseAnimation?.cornerRadius = layer.cornerRadius*1.4
        pulseAnimation?.backgroundColor = self.gradientStartColor.cgColor
        self.layer.insertSublayer(pulseAnimation!, below: self.gradient)
        
    }
}


//MARK: IMPulseButton Nuke Animation funcs
extension IMPulseButton {
    
    func nukeAllAnimations() {
        self.pulseAnimationEnabled = false
        self.timer.invalidate()
        self.pulseAnimation?.removeFromSuperlayer()
        self.subviews.forEach({$0.layer.removeAllAnimations()})
        self.layer.removeAllAnimations()
        self.layoutIfNeeded()
    }
    
    func resetTimer(){
        timer?.invalidate()
        timer = nil
    }
}

class PulseLayerAnimation: CALayer {
    
    var animationGroup = CAAnimationGroup()
    var animationDuration: TimeInterval = 0.6
    var radius: CGFloat = 200
    var numebrOfPulse: Float = 1
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(numberOfPulse: Float = Float.infinity, radius: CGFloat, postion: CGPoint, width: CGFloat, height: CGFloat){
        super.init()
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numebrOfPulse = numberOfPulse
        self.position = postion
        
        self.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: .default).async {
            self.setupAnimationGroup()
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    
    func layerScaleAnimation() -> CABasicAnimation {
        let scaleAnimaton = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimaton.fromValue = NSNumber(value: 0)
        scaleAnimaton.toValue = NSNumber(value: 1)
        scaleAnimaton.duration = animationDuration
        return scaleAnimaton
    }
    
    func layerOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimiation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimiation.duration = animationDuration
        opacityAnimiation.values = [0.6, 0.4, 0]
        opacityAnimiation.keyTimes = [0, 0.6, 1]
        return opacityAnimiation
    }
    
    func setupAnimationGroup() {
        self.animationGroup.duration = animationDuration
        self.animationGroup.repeatCount = numebrOfPulse
        self.animationGroup.timingFunction = CAMediaTimingFunction(name: .default)
        self.animationGroup.animations = [layerScaleAnimation(),layerOpacityAnimation()]
    }
    
}

