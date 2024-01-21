//
//  JMBiometricsPermissionManager.swift
//
//
//  Created by Nevio Hirani on 20.01.24.
//  Github: N3v1  -
//

import UIKit

import LocalAuthentication
import CorePermissionsSwiftUI

/// A permission manager for handling biometric authentication requests.
@available(iOS 13.0, macOS 11.0, *)
public extension PermissionManager {
    /// Shared instance for managing biometric permissions.
    static let opticBiometrics = JMBiometricPermissionManager()
}

/// A permission manager specifically designed for handling biometric authentication requests, such as Face ID, Touch ID and Optic ID.
///
/// `JMBiometricPermissionManager` provides a streamlined interface for checking and requesting biometric authentication permissions.
/// It encapsulates the complexities associated with the LocalAuthentication framework, making it easy to integrate biometric security
/// features into your app. The class is part of the `CorePermissionsSwiftUI` framework and aligns with the standardized `PermissionManager` protocol.
///
/// ## Usage
/// To utilize biometric authentication in your application, follow the guide in the README.md
@available(iOS 13.0, macOS 11.0, *)
public final class JMBiometricPermissionManager: PermissionManager {
    
    public override var permissionType: PermissionType {
        .biometrics
    }
    
    /// Retrieves the current authorization status for biometric authentication.
    ///
    /// - Returns: The current authorization status, indicating whether biometric authentication is authorized, denied, or not determined.
    public override var authorizationStatus: AuthorizationStatus {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            return .authorized
        } else {
            switch error?.code {
            case LAError.Code.biometryLockout.rawValue, LAError.Code.biometryNotAvailable.rawValue,
                LAError.Code.biometryNotEnrolled.rawValue:
                return .denied
            default:
                return .notDetermined
            }
        }
    }
    
    /// Requests permission for biometric authentication with a completion handler.
    ///
    /// - Parameters:
    ///   - completion: A closure to be called once the request is processed.
    ///                 The closure takes a boolean indicating whether the permission was granted
    ///                 and an optional error in case of failure.
    public override func requestPermission(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        
        let localizedReason = "Authenticate to access biometric features"
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason) { success, error in
            DispatchQueue.main.async {
                if success {
                    completion(true, nil)  // Authorized (true), no error
                } else {
                    completion(false, error)  // Not authorized (false), with error
                }
            }
        }
    }
}
