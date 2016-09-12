//
//  dispatch_after_cancellable.swift
//  BluetoothContactTransport
//
//  Created by Nick Brook on 08/08/2016.
//  Copyright © 2016 AfterCross. All rights reserved.
//

import Foundation

private var cancelledTokens: Set<DispatchQueue.AfterCToken> = []
private let internalQueue = DispatchQueue(label: "DispatchQueue.asyncAfterC.internal", attributes: [])

extension DispatchQueue {
    typealias AfterCToken = UUID
    
    func asyncAfterC(deadline: DispatchTime, qos: DispatchQoS = .default, flags: DispatchWorkItemFlags = DispatchWorkItemFlags(rawValue: 0), execute work: @escaping @convention(block) () -> Swift.Void) -> AfterCToken {
        let t: DispatchQueue.AfterCToken = UUID()
        
        self.asyncAfter(deadline: deadline, execute: {
            var cancelled: Bool = false
            _ = internalQueue.sync {
                cancelled = cancelledTokens.contains(t)
                if cancelled {
                    cancelledTokens.remove(t)
                }
            }
            if cancelled {
                return
            }
            work()
        })
        return t
    }
    
    static func asyncAfterCCancel(token: AfterCToken) {
        _ = internalQueue.sync {
            cancelledTokens.insert(token)
        }
    }
    
    func asyncAfterCCancel(token: AfterCToken) {
        DispatchQueue.asyncAfterCCancel(token: token)
    }
}

extension DispatchTime {
    init(timeIntervalSinceNow timeInterval: TimeInterval) {
        self.init(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds + UInt64(timeInterval * TimeInterval(NSEC_PER_SEC)))
    }
}
