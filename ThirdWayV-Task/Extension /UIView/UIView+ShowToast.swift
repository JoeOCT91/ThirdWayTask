//
//  UIView+ShowToast.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 10/06/2022.
//

import Foundation

import UIKit

//MARK: Add Toast method function in UIView Extension so can use in whole project.
extension UIView {
    
    func showToast(toastMessage:String, duration:CGFloat) {

        let toastLabel = UILabel()
        toastLabel.text = toastMessage
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 18)
        toastLabel.textColor = UIColor.white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.numberOfLines = 0
        
        let textSize = toastLabel.intrinsicContentSize
        let labelHeight = ( textSize.width / UIScreen.main.bounds.width ) * 30
        let labelWidth = min(textSize.width, UIScreen.main.bounds.width  - 40)
        let adjustedHeight = max(labelHeight, textSize.height + 20)
        
        toastLabel.frame = CGRect(x: 20, y: (UIScreen.main.bounds.height - 90 ) - adjustedHeight, width: labelWidth + 20, height: adjustedHeight)
        toastLabel.center.x = UIScreen.main.bounds.midX
        toastLabel.layer.cornerRadius = 10
        toastLabel.layer.masksToBounds = true
        
        self.addSubview(toastLabel)
        
        
        UIView.animateKeyframes(withDuration:TimeInterval(duration) , delay: 0, options: [] , animations: {
            toastLabel.alpha = 1
        }, completion: { success in
            UIView.animate(withDuration:TimeInterval(duration), delay: 8, options: [] , animations: {
                toastLabel.alpha = 0
            })
            toastLabel.removeFromSuperview()
        })
    }
}

//MARK: Extension on UILabel for adding insets - for adding padding in top, bottom, right, left.

extension UILabel
{
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }
    
    var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            if let insets = padding {
                contentSize.height += insets.top + insets.bottom
                contentSize.width += insets.left + insets.right
            }
            return contentSize
        }
    }
}

//extension UIViewController {
//    func showToast(message: String) {
//        guard let window = UIApplication.shared.keyWindow else {
//            return
//        }
//        
//        let toastLbl = UILabel()
//        toastLbl.text = message
//        toastLbl.textAlignment = .center
//        toastLbl.font = UIFont.systemFont(ofSize: 18)
//        toastLbl.textColor = UIColor.white
//        toastLbl.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        toastLbl.numberOfLines = 0
//        
//        
//        let textSize = toastLbl.intrinsicContentSize
//        let labelHeight = ( textSize.width / window.frame.width ) * 30
//        let labelWidth = min(textSize.width, window.frame.width - 40)
//        let adjustedHeight = max(labelHeight, textSize.height + 20)
//        
//        toastLbl.frame = CGRect(x: 20, y: (window.frame.height - 90 ) - adjustedHeight, width: labelWidth + 20, height: adjustedHeight)
//        toastLbl.center.x = window.center.x
//        toastLbl.layer.cornerRadius = 10
//        toastLbl.layer.masksToBounds = true
//        
//        window.addSubview(toastLbl)
//        
//        UIView.animate(withDuration: 3.0, animations: {
//            toastLbl.alpha = 0
//        }) { (_) in
//            toastLbl.removeFromSuperview()
//        }
//        
//
