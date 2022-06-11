//
//  BaseUIView.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 10/06/2022.
//

import UIKit
import Combine

class BaseUIView: UIView {
    
    private var networkStatusSubscriptionToken: AnyCancellable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
