@testable import PermissionsSwiftUI
@testable import CorePermissionsSwiftUI
import PermissionsSwiftUITracking
import PermissionsSwiftUIBluetooth
import PermissionsSwiftUICalendar
import PermissionsSwiftUICamera
import PermissionsSwiftUIContacts
import PermissionsSwiftUIHealth
import PermissionsSwiftUILocation
import PermissionsSwiftUILocationAlways
import PermissionsSwiftUIMicrophone
import PermissionsSwiftUIMotion
import PermissionsSwiftUIMusic
import PermissionsSwiftUINotification
import PermissionsSwiftUIPhoto
import PermissionsSwiftUIReminder
import PermissionsSwiftUISpeech
import XCTest
import SwiftUI
import SnapshotTesting 
import HealthKit

private let referenceSize = UIScreen.main.bounds.size
@available(iOS 13.0, tvOS 13.0, *)
final class PermissionsSwiftUITests: XCTestCase {
    func testBindingCombineExtension() {
        let trueBinding = Binding.constant(true)
        let falseBinding = Binding.constant(false)
        XCTAssert(trueBinding.combine(with: .constant(true)).wrappedValue)
        XCTAssertFalse(trueBinding.combine(with: falseBinding).wrappedValue)
        XCTAssertFalse(falseBinding.combine(with: .constant(false)).wrappedValue)
    }
}
@available(iOS 13.0, tvOS 13.0, *)
struct TestViewRedBG:View {
    var body: some View {
        ZStack {
            Color.red
            Text("Test View with red background")
        }
    }
}

@available(iOS 13.0, tvOS 13.0, *)
struct TestViewGreenBG:View {
    var body: some View{
        ZStack {
            Color.green
            Text("Test View with green background")
        }
    }
}
@available(iOS 13.0, tvOS 13.0, *)

private extension SwiftUI.View {
    func referenceFrame(count: Int) -> some View {
        return self.frame(width: referenceSize.width, height: referenceSize.height+CGFloat(count*60))
    }
    func referenceFrameCell() -> some View{
        return self.frame(width: referenceSize.width, height: 70)
    }
}

public extension UIDevice {
    enum DeviceType{
        case iPod7, iPhone12ProMax, iPhone11, unknown
    }
    static var modelName: DeviceType {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        func mapToDevice(identifier: String) -> DeviceType {
            switch identifier {
            case "iPod9,1": return .iPod7
            case "iPhone13,4": return .iPhone12ProMax
            case "iPhone12,1": return .iPhone11
            default: return .unknown
            }
        }
        return mapToDevice(identifier: identifier)
    }
}
