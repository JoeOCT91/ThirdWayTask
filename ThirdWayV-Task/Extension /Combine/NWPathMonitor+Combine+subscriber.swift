//
//  NWPathMonitor+Combine.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 10/06/2022.
//

import Foundation
import Network
import Combine

// MARK: - NWPathMonitor Subscription
extension NWPathMonitor {
    class NetworkStatusSubscription<S: Subscriber>: Subscription where S.Input == NWPath.Status {
        
        private let subscriber: S?
        
        private let monitor: NWPathMonitor
        private let queue: DispatchQueue
        
        init(subscriber: S,monitor: NWPathMonitor, queue: DispatchQueue) {
            self.subscriber = subscriber
            self.monitor = monitor
            self.queue = queue
        }
        
        
        func request(_ demand: Subscribers.Demand) {

            monitor.pathUpdateHandler = { [weak self] path in
                guard let self = self else { return }
                _ = self.subscriber?.receive(path.status)
            }
            
            monitor.start(queue: queue)
        }
        
        func cancel() {
            monitor.cancel()
        }
        
    }
}
