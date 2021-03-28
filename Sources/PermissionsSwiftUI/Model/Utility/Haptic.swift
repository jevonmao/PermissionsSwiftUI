//
//  Haptic.swift
//  
//
//  Created by Jevon Mao on 3/4/21.
//

import Foundation
import UIKit

func notificationImpact(_ type: UINotificationFeedbackGenerator.FeedbackType){
    var notificationFeedbackGenerator: UINotificationFeedbackGenerator? = UINotificationFeedbackGenerator()
    notificationFeedbackGenerator?.prepare()
    notificationFeedbackGenerator?.notificationOccurred(type) 
    notificationFeedbackGenerator = nil
}
