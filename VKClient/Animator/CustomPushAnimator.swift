//
//  CustomPushAnimator.swift
//  VKClient
//
//  Created by AntonSobolev on 04.12.2020.
//

import Foundation
import UIKit

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
//        destination.view.frame = transitionContext.containerView.frame
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(rotationAngle: -.pi * 0.5)
        
        source.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        source.view.frame = transitionContext.containerView.frame

        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.75,
                                                       animations: {
                                                        source.view.transform = CGAffineTransform(rotationAngle: .pi * 0.5)
                                                        destination.view.transform = .identity
                                                       })
                                },
                                completion: { finished in
                                    if finished && !transitionContext.transitionWasCancelled {
                                        source.view.transform = .identity
                                    }
                                    transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
                                })
        
        
    }
    
    
    
}
