//
//  JMPermission.swift
//  
//
//  Created by Jevon Mao on 2/6/21.
//

import Foundation
import SwiftUI
import HealthKit
/**
 A data model that defines a JPPermission component and its data
 
 `JMPermission` conforms to `Equatable` and `Hashable`. The PermissionsSwiftUI view interface will be rendered based on information from `JMPermission` structure
 */

public struct JMPermission: Equatable{

    
    /**
     Initializes a new instance of `JMPermission` that encapsulates properties of a single permission
          
     - Parameters:
        - imageIcon: Defines the image icon displayed for the permission component
        - title: Defines the title text of the permission component
        - description: Defines the description text of the permission component
        - authorized: Tracks the authorization status of ther permission
     */
    public init(imageIcon: AnyView, title: String, description: String) {
        self.imageIcon = imageIcon
        self.title = title
        self.description = description
    }
    internal init(imageIcon: AnyView, title: String, description: String, authorized: Bool) {
        self.imageIcon = imageIcon
        self.title = title
        self.description = description
        self.authorized = authorized
    }
    /**
     Compares two instances of equatable `JMPermission`, based on the title text, description text, and authorized status
     
     `imageIcon` will be ignored by the comparison operature, because it is a type erased `AnyView` and cannot be compared
          
     - Parameters:
        - imageIcon: Defines the image icon displayed for the permission component
        - title: Defines the title text of the permission component
        - description: Defines the description text of the permission component
        - authorized: Tracks the authorization status of ther permission
     */
    public static func == (lhs: JMPermission, rhs: JMPermission) -> Bool {
        if lhs.title == rhs.title && lhs.description == rhs.description && lhs.authorized == rhs.authorized{
            return true
        }
        else{
            return false
        }
    }
    ///The image icon displayed
    public var imageIcon: AnyView
    ///The permission name displayed
    public var title: String
    ///The permission description displayed
    public var description: String
    internal var authorized:Bool = false
    internal var interacted:Bool = false {
        didSet {
            store.objectWillChange.send()
        }
    }
}
/**
 Encapsulates different subtypes of permission for health permission
 
 The structure `HKAccess` is required when initalizing health permission's enum associated values. It encapsulates the read and write type permissions for the health permission.
 */
public struct HKAccess: Hashable {
    ///The HealthKit sample types for read permission
    public var readPermissions: Set<HKSampleType> = Set()
    ///The HealthKit sample types for write permission
    public var writePermissions: Set<HKSampleType> = Set()
    
    /**
     Initializes a new `HKAccess` with separate read and write permissions
     
     - parameters:
        - read: The HealthKit sample types for read permission
        - write: The HealthKit sample types for write permission
     */
    public init(read: Set<HKSampleType>, write: Set<HKSampleType>){
        self.readPermissions = read
        self.writePermissions = write
    }
    /**
     Initializes a new `HKAccess` with read permissions
     
     - parameters:
        - read: The HealthKit sample types for read permission
        - write: The HealthKit sample types for write permission
     */
    public init(read: Set<HKSampleType>){
        self.readPermissions = read
    }
    /**
     Initializes a new `HKAccess` with write permissions
     
     - parameters:
        - read: The HealthKit sample types for read permission
        - write: The HealthKit sample types for write permission
     */
    public init(write: Set<HKSampleType>){
        self.writePermissions = write
    }
}

extension HKAccess {

    /**
     Initializes a new `HKAccess` with same read and write permissions
     
     - parameters:
        - readAndWrite: sample types for read permission
     */
    public init(readAndWrite sharedPermissions: Set<HKSampleType>){
        self.init(read: sharedPermissions, write: sharedPermissions)
    }
}
