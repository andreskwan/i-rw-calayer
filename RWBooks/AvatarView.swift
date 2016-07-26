/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

//the storyBoard doesn't call it from awakeFromNib, it should render the view directly in 
//the canvas, this allows seeing how your custom views will appear without buildin and 
//running your app after each change.
@IBDesignable
class AvatarView: UIView {
    
    let margin: CGFloat = 30.0
    let labelName = UILabel()
    let imageView = UIImageView()
    
    let strokeColor = UIColor.blackColor().CGColor

    let layerGradient = CAGradientLayer()

    //TODO: turn these properties to inspectable to set these from the story board
    let startColor = UIColor.whiteColor()
    let endColor = UIColor.blackColor()

    @IBInspectable var imageAvatar: UIImage? {
        didSet {
            configure()
        }
    }

    @IBInspectable var avatarName: String = "" {
        didSet {
            configure()
        }
    }

    //when the view if first loaded from the storyBoard
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    //IBDesignable - load the view from this method 
    //this method is used when you are previewing the UIViewController in the storyBoard
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    func setup() {
        
        // Setup gradient
        layer.addSublayer(layerGradient)
        
        // Stroke Avatar
        imageView.layer.borderColor = strokeColor
        imageView.layer.borderWidth = 5.0
        imageView.layer.masksToBounds = true
        
        // Setup image view
        imageView.contentMode = .ScaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        // Setup label
        labelName.font = UIFont(name: "AvenirNext-Bold", size: 28.0)
        labelName.textColor = UIColor.blackColor()
        labelName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelName)
        
        labelName.setContentCompressionResistancePriority(1000, forAxis: .Vertical)
        
        // Add constraints for label
        let labelCenterX = labelName.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor)
        let labelBottom = labelName.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor)
        NSLayoutConstraint.activateConstraints([labelCenterX, labelBottom])
        
        // Add constraints for imageView
        let imageViewCenterX = imageView.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor)
        let imageViewTop = imageView.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: margin)
        let imageViewBottom = imageView.bottomAnchor.constraintEqualToAnchor(labelName.topAnchor, constant: -margin)
        let imageViewWidth = imageView.widthAnchor.constraintEqualToAnchor(imageView.heightAnchor)
        NSLayoutConstraint.activateConstraints([imageViewCenterX, imageViewTop, imageViewBottom, imageViewWidth])
    }
    
    //setings that may change
    func configure() {
        
        // Configure image view and label
        imageView.image = imageAvatar
        labelName.text = avatarName
        
        // Configure gradient
        layerGradient.colors = [startColor.CGColor, endColor.CGColor]
        // Seting a vertical gradient
        layerGradient.startPoint = CGPoint(x: 0.5, y: 0)
        layerGradient.endPoint = CGPoint(x:0.5, y: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = CGRectGetHeight(imageView.bounds)/2
        
        // Gradient 
        layerGradient.frame = CGRect(x: 0,
                                     y: 0,
                                     width: CGRectGetWidth(self.bounds),
                                     height: CGRectGetHeight(self.bounds)/2)
        
    }
    
}
