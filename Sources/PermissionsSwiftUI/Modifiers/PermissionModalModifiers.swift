//
//  SwiftUIView.swift
//  
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

// MARK: Public modifiers
struct Permissions: ViewModifier{
    @Binding var showModal:Bool
    var permissions:[PermissionModel]
    func body(content: Content) -> some View {
        MainView(for: AnyView(content), show: $showModal, permissions: permissions)
    }
}

public extension View{
    func JMPermissions(showModal:Binding<Bool>, for permissions:[PermissionModel]) -> some View{
        self.modifier(Permissions(showModal:showModal, permissions: permissions))
    }
}

import Foundation
import CoreLocation

public class LocationPermissionManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var authorisationStatus: CLAuthorizationStatus = .notDetermined

    public override init() {
        super.init()
        self.locationManager.delegate = self
    }

    public func requestAuthorisation(always: Bool = false) {
        if always {
            self.locationManager.requestAlwaysAuthorization()
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationPermissionManager: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorisationStatus = status
    }
}



// MARK: - Package modifiers
struct ButtonStatusColor:ViewModifier{
    var allowButtonStatus:AllowButtonStatus
    func body(content: Content) -> some View {
        switch allowButtonStatus{
        case .idle:
            return content
                .textCase(.uppercase)
                .font(.subheadline)
                .foregroundColor(Color(.systemBlue))
                .padding(4)
                .padding(.horizontal,4)
                .background(
                    Capsule()
                        .fill(Color(.systemGray6))
                )
        case .allowed:
            return content
                .textCase(.uppercase)
                .font(.callout)
                .foregroundColor(.white)
                .padding(4)
                .padding(.horizontal,4)
                .background(
                    Capsule()
                        .fill(Color(.systemBlue))
                )
        case .denied:
            return content
                .textCase(.uppercase)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(4)
                .padding(.horizontal,4)
                .background(
                    Capsule()
                        .fill(Color(.systemRed))
                )
        }
    }
}

extension View{
    func buttonStatusColor(for allowButtonStatus:AllowButtonStatus) -> some View{
        self.modifier(ButtonStatusColor(allowButtonStatus: allowButtonStatus))
    }
}
