//
//  PermissionSection.swift
//  
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI
import MapKit
struct PermissionSection: View {
    var permissions:[PermissionModel]
    var body: some View {
        VStack{
            ForEach(permissions, id:\.self){
                PermissionSectionCell(permission: $0)
                if permissions.count > 1{
                    Divider()
                }
            }
        }
        .background(Color.white)
        .cornerRadius(15, antialiased: true)
        .padding()
        .padding(.horizontal, 5)


    }
}
class LocationDelegate:NSObject, CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse{
            print("authed")
        }
        else{
            print("not authed")
        }
        
    }

}

enum AllowButtonStatus{
    case idle
    case allowed
    case denied
}
struct PermissionSectionCell: View{
    var permission:PermissionModel
    @State var allowButtonStatus:AllowButtonStatus = .idle
    var body: some View{
        let currentPermission = self.permission.currentPermission
        HStack{
            currentPermission.imageIcon
                .foregroundColor(Color.blue)
                .font(.system(size: 40))
                .frame(width:50)
            VStack(alignment: .leading){
                Text(currentPermission.title)
                    .font(.title3)
                    .bold()
                Text(currentPermission.description)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color(.systemGray2))
            }
            .padding(.horizontal, 5)

            Spacer()
            AllowButtonSection(action:{
                permission.requestPermission{authed in
                    if authed{
                        allowButtonStatus = .allowed
                    }
                    else{
                        allowButtonStatus = .idle
                    }
                }
            
            }, allowButtonStatus: $allowButtonStatus)

        }
        .padding(15)
        .onAppear{
        }
    }
}
