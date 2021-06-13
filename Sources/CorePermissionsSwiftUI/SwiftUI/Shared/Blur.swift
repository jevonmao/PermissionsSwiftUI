//
//  Blur.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import SwiftUI

let screenSize = UIScreen.main.bounds

@available(iOS 13.0, tvOS 13.0, *)
struct Blur: UIViewRepresentable {
    #if !os(tvOS)
    var style: UIBlurEffect.Style = .systemMaterial
    #else
    var style: UIBlurEffect.Style = .regular
    #endif
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
