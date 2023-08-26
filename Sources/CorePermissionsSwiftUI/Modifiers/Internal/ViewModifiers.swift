//
//  ViewModifier.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, *)
extension View {
    func buttonStatusColor(for allowButtonStatus: AllowButtonStatus) -> some View {
        self.modifier(ButtonStatusColor(allowButtonStatus: allowButtonStatus))
    }
    func allowButton(foregroundColor: Color, backgroundColor: Color) -> some View {
        self.modifier(AllowButton(foregroundColor: foregroundColor, backgroundColor: backgroundColor))
    }
    func alertViewFrame() -> some View {
        self.modifier(JMAlertViewFrame())
    }
    func textHorizontalAlign(_ alignment: Alignment) -> some View {
        TextHorizontalAlign(alignment: alignment, bodyView: self)
    }
    
    @ViewBuilder
    func compatibleForegroundStyle(_ style: any ShapeStyle) -> some View {
        if #available(iOS 15, *) {
            self.foregroundStyle(style).typeErased()
        }
        else {
            self.foregroundColor(style as? Color).typeErased()
        }
    }
}

//Custom view modifier for the button component
@available(iOS 13.0, tvOS 13.0, *)
struct ButtonStatusColor: ViewModifier {
    var allowButtonStatus: AllowButtonStatus
    @EnvironmentObject var store: PermissionStore

    func body(content: Content) -> some View {
        let colorStore = {
            store.allButtonColors.contentChanged ? store.allButtonColors : store.configStore.allButtonColors
        }()
        switch self.allowButtonStatus {
        case .idle:
            return content.allowButton(foregroundColor: colorStore.buttonIdle.foregroundColor,
                                       backgroundColor: colorStore.buttonIdle.backgroundColor)

        case .allowed:
            return content.allowButton(foregroundColor: colorStore.buttonAllowed.foregroundColor,
                                       backgroundColor: colorStore.buttonAllowed.backgroundColor)


        case .denied:
            return content.allowButton(foregroundColor: colorStore.buttonDenied.foregroundColor,
                                       backgroundColor: colorStore.buttonDenied.backgroundColor)
        }
    }
}
//Custom modifier that nests within ButtonStatusColor to further extract code
@available(iOS 13.0, tvOS 13.0, *)
struct AllowButton: ViewModifier {
    var foregroundColor: Color
    var backgroundColor: Color
    var buttonSizeConstant :CGFloat {
        return screenSize.width < 400 ?  70-(1000-screenSize.width)/30 : 70
    }
    func body(content: Content) -> some View {
        content
        .frame(width: buttonSizeConstant)
        .font(.system(size: 15))
        .minimumScaleFactor(0.2)
        .lineLimit(1)
        .foregroundColor(foregroundColor)
        .padding(.vertical,6)
        .padding(.horizontal, 6)
        .background(
            Capsule()
                .fill(backgroundColor)
        )
    }
}

@available(iOS 13.0, tvOS 13.0, *)
struct JMAlertViewFrame: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(.systemBackground).opacity(0.8))
            .frame(width: screenSize.width > 375 ? 375 : screenSize.width-60)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .edgesIgnoringSafeArea(.all)
    }
}
@available(iOS 13.0, tvOS 13.0, *)
struct TextHorizontalAlign<BodyView: View>: View {
    var alignment: Alignment
    var bodyView: BodyView
    @ViewBuilder
    var body: some View {
        switch alignment {
        case .leading:
            HStack{bodyView; Spacer()}
        case .trailing:
            HStack{Spacer(); bodyView}
        default:
            bodyView
        }
    }
}
