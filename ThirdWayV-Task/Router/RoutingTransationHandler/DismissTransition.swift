//
//  DismissTransition.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 11/06/2022.
//

import UIKit

class DismissTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var animator: UIViewImplicitlyAnimating?
    let duration = 0.9

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }
        
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if self.animator != nil { return self.animator! }
        
        let fromVC = transitionContext.viewController(forKey: .from)!
        
        var fromViewInitialFrame = transitionContext.initialFrame(for: fromVC)
        
        fromViewInitialFrame.origin.x = 0
        var fromViewFinalFrame = fromViewInitialFrame
        fromViewFinalFrame.origin.x = fromViewFinalFrame.width
        
        let fromView = fromVC.view!
        let toView = transitionContext.viewController(forKey: .to)!.view!
        
        var toViewInitialFrame = fromViewInitialFrame
        toViewInitialFrame.origin.x = 0
        
        toView.frame = toViewInitialFrame
        
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            
            toView.frame = fromViewInitialFrame
            fromView.frame = fromViewFinalFrame
        }
        
        animator.addCompletion { _ in
            transitionContext.completeTransition(true)
        }
        
        self.animator = animator
        return animator
    }
}
