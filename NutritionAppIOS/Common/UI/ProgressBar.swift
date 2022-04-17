//
//  RoundProgressBar.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 11.06.2021.
//


//Created by Real Life Swift on 16/02/2019
import UIKit

class ProgressBar: UIView {
  
    @IBInspectable public lazy var backgroundCircleColor: UIColor = UIColor(displayP3Red: 184/255, green: 233/255, blue: 134/255, alpha: 0.23)
  @IBInspectable public lazy var foregroundCircleColor: UIColor = UIColor.red
  @IBInspectable public lazy var startGradientColor: UIColor = UIColor(displayP3Red: 23/255, green: 152/255, blue: 0, alpha: 1)
  @IBInspectable public lazy var endGradientColor: UIColor = UIColor(displayP3Red: 167/255, green: 255/255, blue: 7/255, alpha: 1)
  @IBInspectable public lazy var textColor: UIColor = UIColor(displayP3Red: 126/255, green: 211/255, blue: 33/255, alpha: 1)
@IBInspectable public lazy var textColor2: UIColor = UIColor(displayP3Red: 212/255, green: 212/255, blue: 212/255, alpha: 1)

  private lazy var fillColor: UIColor = UIColor.clear
  
  private var backgroundLayer: CAShapeLayer!
  private var progressLayer: CAShapeLayer!
  private var textLayer: CATextLayer!
  private var textLayer2: CATextLayer!

    public var progress: CGFloat = 0.9 {
    didSet {
      didProgressUpdated()
    }
  }
  
  public var animationDidStarted: (()->())?
  public var animationDidCanceled: (()->())?
  public var animationDidStopped: (()->())?
  
  private var timer: AppTimer?
    
  private var isAnimating = false
  private let tickInterval = 0.1
  
  public var maxDuration: Int = 3
  
  
  override func draw(_ rect: CGRect) {
    
    guard layer.sublayers == nil else {
      return
    }
    
 //   let lineWidth = min(frame.size.width, frame.size.height) * 0.1
    
    backgroundLayer = createCircularLayer(strokeColor: backgroundCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: 4)
    
    progressLayer = createCircularLayer(strokeColor: foregroundCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: 12)
    progressLayer.strokeEnd = progress
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    
    gradientLayer.colors = [startGradientColor.cgColor, endGradientColor.cgColor]
    gradientLayer.frame = self.bounds
    gradientLayer.mask = progressLayer
 
    textLayer = createTextLayer(textColor: textColor)
    textLayer2 = createTextLayer2(textColor: textColor2)

    layer.addSublayer(backgroundLayer)
    layer.addSublayer(gradientLayer)
    layer.addSublayer(textLayer)
    layer.addSublayer(textLayer2)

  }
  
  private func createCircularLayer(strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
    
    let startAngle = -CGFloat.pi / 2
    let endAngle = 2 * CGFloat.pi + startAngle
    
    let width = frame.size.width
    let height = frame.size.height
    
    var templineWidth = lineWidth
    let center = CGPoint(x: width / 2, y: height / 2)
    if lineWidth == 4 {
        templineWidth = lineWidth*3
    }
    let radius = (min(width, height) - templineWidth) / 2
    print(radius)
    let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    
    let shapeLayer = CAShapeLayer()
    
    shapeLayer.path = circularPath.cgPath
    
    shapeLayer.strokeColor = strokeColor
    shapeLayer.lineWidth = lineWidth
    shapeLayer.fillColor = fillColor
    shapeLayer.lineCap = .round
    
    return shapeLayer
  }
  
  private func createTextLayer(textColor: UIColor) -> CATextLayer {
    
    let width = frame.size.width
    let height = frame.size.height
    
    let fontSize = CGFloat(28)
    let offset = min(width, height) * 0.1
    
    let layer = CATextLayer()
    layer.string = "\(Int(progress * 100))"
    layer.backgroundColor = UIColor.clear.cgColor
    layer.foregroundColor = textColor.cgColor
    layer.font = UIFont(name: "AvenirNext-DemiBold", size: fontSize)
    layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: height)
    layer.alignmentMode = .center
    
    return layer
  }
    
    private func createTextLayer2(textColor: UIColor) -> CATextLayer {
      
      let width = frame.size.width
      let height = frame.size.height
      
      let fontSize = CGFloat(10)
      let offset = min(width, height) * 0.1
      
      let layer = CATextLayer()
      layer.string = "ккал осталось"
      layer.backgroundColor = UIColor.clear.cgColor
      layer.foregroundColor = textColor.cgColor
      layer.font = UIFont(name: "AvenirNext-Regular", size: fontSize)
      layer.alignmentMode = .center
      
      return layer
    }
  
  private func didProgressUpdated() {
    
    textLayer?.string = "\(Int(progress * 100))"
    progressLayer?.strokeEnd = progress
  }
}

// Animation
extension ProgressBar {
  
  func startAnimation(duration: TimeInterval) {
    
    print("Start animation")
    isAnimating = true
    
    progressLayer.removeAllAnimations()
    
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    basicAnimation.duration = duration
    basicAnimation.toValue = progress
    
    basicAnimation.delegate = self
    
    timer = AppTimer(duration: maxDuration, tickInterval: tickInterval)
    
    timer?.timerFired = { [weak self] value in
      self?.textLayer.string = "\(value)"
    }
    
    timer?.timerStopped = { [weak self] in
      self?.textLayer.string = ""
    }
    
    timer?.timerCompleted = {}
    
    progressLayer.add(basicAnimation, forKey: "recording")
    timer?.start()
  }
  
  func stopAnimation() {
    timer?.stop()
    progressLayer.removeAllAnimations()
  }
  
}

extension ProgressBar: CAAnimationDelegate {
  
  func animationDidStart(_ anim: CAAnimation) {
    animationDidStarted?()
  }
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    isAnimating = false
    flag ? animationDidStopped?() : animationDidCanceled?()
  }
  
}




class AppTimer {
  
  private var timer: Timer?
  
  var timerStarted: (()->())?
  var timerStopped: (()->())?
  var timerFired: ((Int)->())?
  var timerCompleted: (()->())?
  
  var isRunning: Bool {
    if let isTimerValid = timer?.isValid {
      return isTimerValid
    }
    return false
  }
  
  var duration: Int = 3
  var tickInterval: TimeInterval = 0.1
  
  init(duration: Int, tickInterval: TimeInterval) {
    self.duration = duration
    self.tickInterval = tickInterval
  }
  
  func start() {
    DispatchQueue.main.async { [weak self] in
      guard let strongSelf = self else { return }
      
      if strongSelf.timer != nil {
        strongSelf.timer?.invalidate()
        strongSelf.timer = nil
      }
      
      strongSelf.timer = Timer.scheduledTimer(timeInterval: strongSelf.tickInterval, target: strongSelf, selector: #selector(strongSelf.handleTimerTrigger), userInfo: nil, repeats: true)
      strongSelf.timer?.fire()
      strongSelf.timerStarted?()
    }
  }
  
  func stop() {
    DispatchQueue.main.async { [weak self] in
      guard let strongSelf = self else { return }
      
      strongSelf.timer?.invalidate()
      strongSelf.timer = nil
      strongSelf.timerStopped?()
    }
  }
  
  @objc private func handleTimerTrigger() {
    if duration > 0 {
      timerFired?(duration)
      duration -= 1
      return
    }
    stop()
    timerCompleted?()
  }
  
}
