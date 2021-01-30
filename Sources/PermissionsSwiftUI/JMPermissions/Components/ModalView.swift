//
//  ModalView.swift
//  
//
//  Created by Jevon Mao on 1/30/21.
//

import SwiftUI

struct ModalView: View {
    @Binding var showModal:Bool
    var body: some View {
        VStack {
            HStack {
                Text("Need Permissions")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                
                Spacer()
                Button(action: {showModal.toggle()}, label: {
                    Circle()
                        .fill(Color.black.opacity(0.2))
                        .frame(width:40, height: 40)
                        .overlay(
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(Color.black)
                        )
                        
                })
            }
            .padding()
            .padding(.top,10)
            
            Text("In order for you use certain features of this app, you need to give permissions. See description for each permission")
                .font(.system(.body, design: .rounded))
                .foregroundColor(Color(.systemGray2))
                .padding()
            Spacer()
        }
        .background(Color(.systemGray4))
        .edgesIgnoringSafeArea(.all)
        
        
    }
}

