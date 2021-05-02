//
//  File.swift
//  
//
//  Created by Jevon Mao on 3/26/21.
//

import Foundation

protocol ComponentsStore {
    var cameraPermission: JMPermission {get set}
    var locationPermission: JMPermission {get set}
    var locationAlwaysPermission: JMPermission {get set}
    var photoPermission: JMPermission {get set}
    var microphonePermisson: JMPermission {get set}
    var notificationPermission: JMPermission {get set}
    var calendarPermisson: JMPermission {get set}
    var bluetoothPermission: JMPermission {get set}
    var trackingPermission: JMPermission {get set}
    var contactsPermission: JMPermission {get set}
    var motionPermission: JMPermission {get set}
    var remindersPermission: JMPermission {get set}
    var speechPermission: JMPermission {get set}
    var healthPermission: JMPermission {get set}
    var musicPermission: JMPermission {get set}
}

