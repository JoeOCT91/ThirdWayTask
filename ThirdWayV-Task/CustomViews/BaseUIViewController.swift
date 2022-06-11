//
//  BaseUIViewController.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 11/06/2022.
//

import UIKit
import Combine

class BaseUIViewController: UIViewController {
    
    private var networkStatusSubscriptionToken: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeNetworkConnectionState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        networkStatusSubscriptionToken?.cancel()
    }
    private func observeNetworkConnectionState() {
        networkStatusSubscriptionToken = Reachability.isDisconnected
            .sink { [weak self] netWorkStatus in
                guard let self = self else { return }
                    self.showAlert(message: "Internet connection is lost")
                }
    }
    
    
}
