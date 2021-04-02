//
//  Haptic.swift
//  
//
//  Created by Jevon Mao on 3/4/21.
//

import Foundation
import UIKit

class HapticsManager {
    var notificationFeedbackGenerator: UINotificationFeedbackGenerator?
    init() {
        notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator?.prepare()
    }
    func notificationImpact(_ type: UINotificationFeedbackGenerator.FeedbackType){
        notificationFeedbackGenerator?.notificationOccurred(type)
        notificationFeedbackGenerator = nil
    }
}
