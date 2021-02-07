@testable import PermissionsSwiftUI
import XCTest
import SwiftUI
import SnapshotTesting

fileprivate let referenceSize = UIScreen.main.bounds.size
final class PermissionsSwiftUITests: XCTestCase {
    let placeholderText = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec congue metus.
"""
    func testPermissionStore(){
        PermissionModel.resetPermissionsModelStore()
        if #available(iOS 14.5, *) {
            let trackingPermission = PermissionModel.tracking.currentPermission
            XCTAssertEqual(trackingPermission, JMPermission(
                imageIcon: AnyView(Image(systemName: "person.circle.fill")),
                title: "Tracking",
                description: "Allow to track your data", authorized: false
            ))
        }
        let photoPermission = PermissionModel.photo.currentPermission
        let cameraPermission = PermissionModel.camera.currentPermission
        let locationPermission = PermissionModel.location.currentPermission
        let reminderPermission = PermissionModel.reminders.currentPermission
        let speechPermission = PermissionModel.speech.currentPermission
        let bluetoothPermission = PermissionModel.bluetooth.currentPermission
        let calendarPermission = PermissionModel.calendar.currentPermission
        let contactsPermission = PermissionModel.contacts.currentPermission
        let locationAlwaysPermission = PermissionModel.locationAlways.currentPermission
        let microphonePermission = PermissionModel.microphone.currentPermission
        let notificationPermission = PermissionModel.notification.currentPermission
        XCTAssertEqual(photoPermission, JMPermission(
            imageIcon: AnyView(Image(systemName: "photo")),
            title: "Photo Library",
            description: "Allow to access your photos", authorized: false
        ))
        XCTAssertEqual(cameraPermission, JMPermission(
                        imageIcon: AnyView(Image(systemName: "camera.fill")),
                        title: "Camera",
                        description: "Allow to use your camera", authorized: false))
        XCTAssertEqual(locationPermission, JMPermission(
            imageIcon: AnyView(Image(systemName: "location.fill.viewfinder")),
            title: "Location",
            description: "Allow to access your location", authorized: false
        ))
        XCTAssertEqual(reminderPermission, JMPermission(
            imageIcon: AnyView(Image(systemName: "list.bullet.rectangle")),
            title: "Reminders",
            description: "Allow to access your reminders", authorized: false
        ))
        XCTAssertEqual(speechPermission, JMPermission(
            imageIcon: AnyView(Image(systemName: "rectangle.3.offgrid.bubble.left.fill")),
            title: "Speech",
            description: "Allow to access speech recognition", authorized: false
        ))
        XCTAssertEqual(bluetoothPermission, JMPermission(
            imageIcon: AnyView(Image(systemName: "wave.3.left.circle.fill")),
            title: "Bluetooth",
            description: "Allow to use bluetooth", authorized: false
        ))
        XCTAssertEqual(calendarPermission, JMPermission(
            imageIcon: AnyView(Image(systemName: "calendar")),
            title: "Calendar",
            description: "Allow to access calendar", authorized: false
        ))
        XCTAssertEqual(contactsPermission, JMPermission(
            imageIcon: AnyView(Image(systemName: "book.fill")),
            title: "Contacts",
            description: "Allow to access your contacts", authorized: false
        ))
        XCTAssertEqual(locationAlwaysPermission, JMPermission(
            imageIcon: AnyView(Image(systemName: "location.fill.viewfinder")),
            title: "Location Always",
            description: "Allow to access your location", authorized: false
        ))
        XCTAssertEqual(microphonePermission, JMPermission(
            imageIcon: AnyView(Image(systemName: "mic.fill")),
            title: "Microphone",
            description: "Allow to record with microphone", authorized: false
        ))
        XCTAssertEqual(notificationPermission, JMPermission(
            imageIcon: AnyView(Image(systemName: "bell.fill")),
            title: "Notification",
            description: "Allow to send notifications", authorized: false
        ))
        
    }
    func testLocationPermissionManager(){
        let manager = MockCLLocationManager()
        let JMManager = JMLocationPermissionManager(locationManager: manager)
        DispatchQueue.main.async {
            JMManager.requestInUsePermission{
                XCTAssert($0)
            }
            JMManager.requestAlwaysPermission{
                XCTAssert($0)
            }
            
        }
    }
    func testPermissionManagers() {
        DispatchQueue.main.async {
            JMContactsPermissionManager.shared.requestPermission{
                XCTAssert($0)
            }
            JMMicPermissionManager.shared.requestPermission{
                XCTAssert($0)
            }
            JMBluetoothPermissionManager.shared.requestPermission{
                XCTAssert($0)
            }
            JMCalendarPermissionManager.shared.requestPermission{
                XCTAssert($0)
            }
            JMCameraPermissionManager.shared.requestPermission{
                XCTAssert($0)
            }
            JMMotionPermissionManager.shared.requestPermission{
                XCTAssert($0)
            }
            //        JMNotificationPermissionManager.shared.requestPermission{
            //            XCTAssert($0)
            //        }
            //        JMPhotoPermissionManager.shared.requestPermission{
            //            XCTAssert($0)
            //        }
            
            JMRemindersPermissionManager.shared.requestPermission{
                XCTAssert($0)
            }
            JMSpeechPermissionManager.shared.requestPermission{
                XCTAssert($0)
            }
            if #available(iOS 14.5, *) {
                JMTrackingPermissionManager.shared.requestPermission{
                    XCTAssert($0)
                }
            }
        }
        
    }
    func testModalViewSnapshot(){
        PermissionModel.resetPermissionsModelStore()
        let view = ModalView(showModal: .constant(true))
        PermissionModel.PermissionModelStore.permissions = PermissionModel.allCases
        assertSnapshot(matching: view.referenceFrame(), as: .image)
    }
    func testCustomizeHeaderSnapshot(){
        PermissionModel.resetPermissionsModelStore()
        let view = ModalView(showModal: .constant(true))
            .referenceFrame()
            .changeHeaderTo("Permissions Request")
            .changeHeaderDescriptionTo(placeholderText)
            .changeBottomDescriptionTo(placeholderText)
        assertSnapshot(matching: view, as: .image)
        
    }
    func testPermissionCell(){
        for permission in PermissionModel.allCases{
            let title = permission.currentPermission.title
            let view = getPermissionView(for: permission)
            let testingPermission = JMPermission(imageIcon: AnyView(Image(systemName: "gear")), title: "Testing \(title)", description: placeholderText, authorized: false)
            XCTAssertEqual(testingPermission, permission.currentPermission)
            assertSnapshot(matching: view, as: .image)
        }
    }
    func getPermissionView(for permission:PermissionModel) -> AnyView{
        let title = permission.currentPermission.title
        switch permission {
        case .location:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizeLocationPermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
        case .locationAlways:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizeLocationAlwaysPermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
        case .photo:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizePhotoPermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
        case .microphone:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizeMicrophonePermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
        case .camera:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizeCameraPermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
        case .notification:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizeNotificationPermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
        case .calendar:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizeCalendarPermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
        case .bluetooth:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizeBluetoothPermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
        case .tracking:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizeTrackingPermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
        case .contacts:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizeContactsPermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
        case .motion:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizeMotionPermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
        case .reminders:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizeRemindersPermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
        case .speech:
            let view = PermissionSectionCell(permission: permission, allowButtonStatus: .idle, showModal: .constant(true))
                .customizeSpeechPermissionWith(image: Image(systemName: "gear"), title: "Testing \(title)", description: placeholderText)
                .referenceFrameCell()
            return AnyView(view)
            
        }
    }
//    func testMicrophoneCell(){
//        let permission = PermissionModel.microphone
//        let view = PermissionSectionCell(permission:permission , allowButtonStatus: .idle, showModal: .constant(true))
//            .customizeMicrophonePermissionWith(image: Image(systemName: "gear"), title: "Testing", description: placeholderText)
//            .referenceFrameCell()
//        let testingPermission = JMPermission(imageIcon: AnyView(Image(systemName: "gear")), title: "Testing", description: placeholderText, authorized: false)
//        XCTAssertEqual(testingPermission, PermissionModel.PermissionModelStore.microphonePermisson)
//        assertSnapshot(matching: view, as: .image)
//    }
//    func testBluetoothCell(){
//        let permission = PermissionModel.bluetooth
//        let view = PermissionSectionCell(permission:permission , allowButtonStatus: .idle, showModal: .constant(true))
//            .customizeBluetoothPermissionWith(image: Image(systemName: "gear"), title: "Testing", description: placeholderText)
//            .referenceFrameCell()
//        XCTAssertEqual(testingPermission, PermissionModel.PermissionModelStore.bluetoothPermission)
//        assertSnapshot(matching: view, as: .image)
//    }
//    func testCameraCell(){
//        let permission = PermissionModel.camera
//        let view = PermissionSectionCell(permission:permission , allowButtonStatus: .idle, showModal: .constant(true))
//            .customizeCameraPermissionWith(image: Image(systemName: "gear"), title: "Testing", description: placeholderText)
//            .referenceFrameCell()
//        let testPermission =
//        assertSnapshot(matching: view, as: .image)
//    }
    static var allTests = [
        ("testPermissionManagers", testPermissionManagers),
        ("testLocationPermissionManager",testLocationPermissionManager)
    ]
}
private extension SwiftUI.View {
    func referenceFrame() -> some View {
        let count = PermissionModel.PermissionModelStore.permissions.count
        return self.frame(width: referenceSize.width, height: referenceSize.height+CGFloat(count*60))
    }
    func referenceFrameCell() -> some View{
        return self.frame(width: referenceSize.width, height: 70)
    }
}
