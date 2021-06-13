//
//  HKAccess.swift
//  
//
//  Created by Jevon Mao on 3/17/21.
//

import Foundation
#if !os(tvOS)
import HealthKit
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
    
    public init(){}
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
#endif
