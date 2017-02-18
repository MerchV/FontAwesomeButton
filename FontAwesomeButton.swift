//
//  FontAwesomeButton.swift
//
//  Created by Merch Visoiu on 2015-08-13.
//

import UIKit

/*
 HOW TO USE
 
 Search at http://fontawesome.io/icons/
 In Interface Builder, use the inspector to enter a value in the Unicode field. E.g., f08e, f00d, etc.
 
 You must also have FontAwesome.otf in your bundle. 
 */

@IBDesignable class FontAwesomeButton: UIButton {

    var originalBackgroundColor: UIColor!
        
    override var backgroundColor: UIColor? {
        didSet {
            originalBackgroundColor = originalBackgroundColor == nil ? backgroundColor : originalBackgroundColor
        }
    }
    
    @IBInspectable var highlightedContentColor: UIColor?
    @IBInspectable var highlightedBackgroundColor: UIColor?
    @IBInspectable var dropShadow: Bool = false {
        didSet {
            if dropShadow == true {
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                layer.shadowOpacity = 0.5
                layer.shadowRadius =  1.0
                layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 0).cgPath
                layer.shouldRasterize = true
                layer.rasterizationScale = UIScreen.main.scale
            }
        }
    }
    
    @IBInspectable var unicode: String? {
        didSet {
            let scanner = Scanner(string: unicode!)
            var hexInt = UInt32.min
            _ = scanner.scanHexInt32(&hexInt)
            let unicodeIcon = Character(UnicodeScalar(hexInt)!)
            let awesomeFont = UIFont(name: "FontAwesome", size: (titleLabel?.font.pointSize)!)
            let normalTitleMutableAttributedString = NSMutableAttributedString()
            let highlightedTitleMutableAttributedString = NSMutableAttributedString()
            normalTitleMutableAttributedString.append(NSAttributedString(string: "\(unicodeIcon)", attributes: [NSFontAttributeName:awesomeFont!, NSForegroundColorAttributeName:titleColor(for: .normal)!]))
            highlightedTitleMutableAttributedString.append(NSAttributedString(string: "\(unicodeIcon)", attributes: [NSFontAttributeName:awesomeFont!, NSForegroundColorAttributeName:titleColor(for: .highlighted)!]))
            setAttributedTitle(normalTitleMutableAttributedString, for: .normal)
            setAttributedTitle(highlightedTitleMutableAttributedString, for: .highlighted)
        }
    }
    
    
    override var isHighlighted: Bool {
        didSet {
            if highlightedBackgroundColor != nil { // this is set in the inspector in Interface Builder
                backgroundColor = isHighlighted == true ? highlightedBackgroundColor : originalBackgroundColor
            }
            if highlightedContentColor != nil {
                let scanner = Scanner(string: unicode!)
                var hexInt = UInt32.min
                _ = scanner.scanHexInt32(&hexInt)
                let unicodeIcon = Character(UnicodeScalar(hexInt)!)
                let awesomeFont = UIFont(name: "FontAwesome", size: (titleLabel?.font.pointSize)!)
                let highlightedAttributes = [NSFontAttributeName:awesomeFont!, NSForegroundColorAttributeName:highlightedContentColor] as! [String:Any]
                let highlightedTitleAttributedString = NSAttributedString(string: "\(unicodeIcon)", attributes: highlightedAttributes)
                setAttributedTitle(highlightedTitleAttributedString, for: .highlighted)
            }
        }
    }
    
    
}
