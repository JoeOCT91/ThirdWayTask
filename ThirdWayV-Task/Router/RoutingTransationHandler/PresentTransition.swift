//
//  PresentTransition.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 11/06/2022.
//

import UIKit

class PresentTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
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
        
        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)!
        
        let fromViewInitialFrame = transitionContext.initialFrame(for: fromVC).inset(by: UIEdgeInsets(top: 45, left: 35, bottom: 35, right: 35))
        let fromViewFinalFrame = transitionContext.initialFrame(for: fromVC)
        
        let fromView = fromVC.view!
        let toView = transitionContext.view(forKey: .to)!
        
        var toViewInitialFrame = fromViewInitialFrame
        toViewInitialFrame.origin.x = fromViewFinalFrame.maxX
        
        toView.frame = .zero
        container.addSubview(toView)
        
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
    
    func animationEnded(_ transitionCompleted: Bool) {
        self.animator = nil
    }
}
