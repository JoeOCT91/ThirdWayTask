//
//  File.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 10/06/2022.
//

import Network
import Combine

// MARK: - NWPathMonitor Publisher
extension NWPathMonitor {
    
    struct NetworkStatusPublisher: Publisher {
        
        typealias Output = NWPath.Status
        typealias Failure = Never
        
        private let monitor: NWPathMonitor
        private let queue: DispatchQueue
        
        init(monitor: NWPathMonitor, queue: DispatchQueue) {
            
            self.monitor = monitor
            self.queue = queue
        }
        
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, NWPath.Status == S.Input {
            
            let subscription = NetworkStatusSubscription( subscriber: subscriber, monitor: monitor, queue: queue)
            subscriber.receive(subscription: subscription)
        }
    }
    
    
    func publisher(queue: DispatchQueue) -> NWPathMonitor.NetworkStatusPublisher {
        return NetworkStatusPublisher(monitor: self, queue: queue)
    }
}
