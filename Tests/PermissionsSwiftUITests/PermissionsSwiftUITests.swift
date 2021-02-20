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
        PermissionStore.resetPermissionsModelStore()
        if #available(iOS 14.5, *) {
            let trackingPermission = PermissionType.tracking.currentPermission
            XCTAssertEqual(trackingPermission, JMPermission(
                imageIcon: AnyView(Image(systemName: "person.circle.fill")),
                title: "Tracking",
                description: "Allow to track your data", authorized: false
            ))
        }
        let photoPermission = PermissionType.photo.currentPermission
        let cameraPermission = PermissionType.camera.currentPermission
        let locationPermission = PermissionType.location.currentPermission
        let reminderPermission = PermissionType.reminders.currentPermission
        let speechPermission = PermissionType.speech.currentPermission
        let bluetoothPermission = PermissionType.bluetooth.currentPermission
        let calendarPermission = PermissionType.calendar.currentPermission
        let contactsPermission = PermissionType.contacts.currentPermission
        let locationAlwaysPermission = PermissionType.locationAlways.currentPermission
        let microphonePermission = PermissionType.microphone.currentPermission
        let notificationPermission = PermissionType.notification.currentPermission
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
//        XCTAssertEqual(healthPermission, JMPermission(
//            imageIcon: AnyView(Image(systemName: "heart.fill")),
//            title: "Health",
//            description: "Allow to access your health information",
//            authorized: false))
        //Additional test for failing case
        XCTAssertNotEqual(notificationPermission, JMPermission(
            imageIcon: AnyView(Image(systemName: "bell.fill")),
            title: "Test_Notification",
            description: "Allow to send notifications", authorized: false
        ))
        
    }
    func testLocationPermissionManager(){
        let manager = MockCLLocationManager()
        let JMManager = JMLocationPermissionAlwaysManager(locationManager: manager)
        let JMAlwaysManager = JMLocationInUsePermissionManager(locationManager: manager)
        //FIXME: Dummy test will always pass
        //TODO: Mock location manager delegate
        //TODO: Reimplement XCTAssert to check for Bool callback (whether permission is authorized)
        JMManager.requestPermission{_ in
            XCTAssert(true)
        }
        JMAlwaysManager.requestPermission{_ in
                XCTAssert(true)
            }
            
        
    }
    func testPermissionManagers() {
//        for i in PermissionType.allCases{
//            permissionManagerMethod(for: i)
//        }
        DispatchQueue.main.async {
            JMContactsPermissionManager.shared.requestPermission{
                XCTAssertTrue($0)
            }
            JMMicPermissionManager.shared.requestPermission{
                XCTAssertTrue($0)
            }
            JMBluetoothPermissionManager.shared.requestPermission{
                XCTAssertTrue($0)
            }
            JMCalendarPermissionManager.shared.requestPermission{
                XCTAssertTrue($0)
            }
            JMCameraPermissionManager.shared.requestPermission{
                XCTAssertTrue($0)
            }
            JMMotionPermissionManager.shared.requestPermission{
                XCTAssertTrue($0)
            }
            
            JMRemindersPermissionManager.shared.requestPermission{
                XCTAssertTrue($0)
            }
            JMSpeechPermissionManager.shared.requestPermission{
                XCTAssertTrue($0)
            }
//            let healthPermissions:Set<HKSampleType> = Set(
//            [HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!])
//            JMHealthPermissionManager.shared.requestPermission(for: healthPermissions){
//                XCTAssertTrue($0)
//            }
            if #available(iOS 14.5, *) {
                JMTrackingPermissionManager.shared.requestPermission{
                    XCTAssertTrue($0)
                }
            }
        }
        
    }
    func permissionManagerMethod(for permission:PermissionType){
        switch permission {
        default:
            let expectation = self.expectation(description: "Requesting permission access")
            var permissionGranted:Bool?
            DispatchQueue.main.async {
                JMRemindersPermissionManager.shared.requestPermission{
                    permissionGranted = $0
                    expectation.fulfill()
                }
            }
            waitForExpectations(timeout: 5, handler: nil)
            XCTAssertTrue(permissionGranted ?? false)
        }

//        case .location:
//            return store.locationPermission
//        case .locationAlways:
//            return store.locationAlwaysPermission
//        case .photo:
//            return store.photoPermission
//        case .microphone:
//            return store.microphonePermisson
//        case .camera:
//            return store.cameraPermission
//        case .notification:
//            return store.notificationPermission
//        case .calendar:
//            return store.calendarPermisson
//        case .bluetooth:
//            return store.bluetoothPermission
//        case .tracking:
//            return store.trackingPermission
//        case .contacts:
//            return store.contactsPermission
//        case .motion:
//            return store.motionPermission
//        case .reminders:
//            return store.remindersPermission
//        case .speech:
//            return store.speechPermission
        

    }
    func testPhotoPermission(){
        let photoPermissionManager = JMPhotoPermissionManager(photoLibrary: MockPhotoManager.self)
        photoPermissionManager.requestPermission{
            XCTAssert($0)
        }
    }
    func testModalViewSnapshot14_0(){
        if #available(iOS 14.5, *) {}
        else{
            PermissionStore.resetPermissionsModelStore()
            let view = ModalView(showModal: .constant(true))
            PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: PermissionType.allCases)
            assertSnapshot(matching: view.referenceFrame(), as: .image)
        }
    }
    func testModalViewSnapshot14_5(){
        if #available(iOS 14.5, *) {
            PermissionStore.resetPermissionsModelStore()
            let view = ModalView(showModal: .constant(true))
            PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: PermissionType.allCases)
            assertSnapshot(matching: view.referenceFrame(), as: .image)
        }
    }
    func testCustomizeHeaderSnapshot(){
        PermissionStore.resetPermissionsModelStore()
        let newHeader = "Permissions Request"
        let view = ModalView(showModal: .constant(true))
            .referenceFrame()
            .changeHeaderTo(newHeader)
            .changeHeaderDescriptionTo(placeholderText)
            .changeBottomDescriptionTo(placeholderText)
        XCTAssertEqual(newHeader, PermissionStore.shared.mainTexts.headerText)
        XCTAssertEqual(placeholderText, PermissionStore.shared.mainTexts.headerDescription)
        XCTAssertEqual(placeholderText, PermissionStore.shared.mainTexts.bottomDescription)
        assertSnapshot(matching: view, as: .image)
        
    }
    func testPermissionCell(){
        for permission in PermissionType.allCases{
            let title = permission.currentPermission.title
            let views = getPermissionView(for: permission)
            let testingPermission = JMPermission(imageIcon: AnyView(Image(systemName: "gear")), title: "Testing \(title)", description: placeholderText, authorized: false)
            XCTAssertEqual(testingPermission, permission.currentPermission)
            for i in views{
                assertSnapshot(matching: i, as: .image)
            }
        }
    }
    func getPermissionView(for permission: PermissionType) -> [AnyView]{
        let title = permission.currentPermission.title
        switch permission {
        default:
            let views:[AnyView] = AllowButtonStatus.allCases.map{
                let view = PermissionSectionCell(permission: permission, allowButtonStatus: $0, showModal: .constant(true), isAlert: false)
                    .setPermissionComponent(for: permission, image: AnyView(Image(systemName: "gear")), title: "Testing \(title)", description: placeholderText)
                    .referenceFrameCell()
                return AnyView(view)
            }
            return views
            
        }
    }
    func testStateChangeClosures(){
        XCTAssertNil(PermissionStore.shared.onAppear)
        XCTAssertNil(PermissionStore.shared.onDisappear)
        var testString = ""
        let onAppear = {
            testString = "appeared"
        }
        let onDisappear = {
            testString = "disappeared"
        }
        _ = EmptyView().JMModal(showModal: .constant(true), for: [], onAppear: onAppear, onDisappear: onDisappear)
        XCTAssertNotNil(PermissionStore.shared.onAppear)
        XCTAssertNotNil(PermissionStore.shared.onAppear)
        MainView.testCallOnAppear()
        XCTAssertEqual(testString, "appeared")
        MainView.testCallOnDisappear()
        XCTAssertEqual(testString, "disappeared")
    }
    func testNotificationPermission(){
        let mockManager = MockNotificationManager()
        var notificationManager = JMNotificationPermissionManager(notificationManager: mockManager)
        notificationManager.requestPermission{XCTAssertTrue($0)}
        var status = notificationManager.authorizationStatus
        XCTAssertEqual(status, .authorized)
        
        mockManager.authStatus = .denied
        notificationManager = JMNotificationPermissionManager(notificationManager: mockManager)
        notificationManager.requestPermission{XCTAssertFalse($0)}
        status = notificationManager.authorizationStatus
        XCTAssertEqual(status, .denied)
        
        
    }

    func testAlertView(){
        let view = EmptyView().JMAlert(showModal: .constant(true), for: [.bluetooth])
        assertSnapshot(matching: view, as: .image)
    }

    static var allTests = [
        ("testPermissionManagers", testPermissionManagers),
        ("testLocationPermissionManager",testLocationPermissionManager)
    ]
}

struct testViewRedBG:View{
    var body: some View{
        ZStack {
            Color.red
            Text("Test View with red background")
        }
    }
}
struct testViewGreenBG:View{
    var body: some View{
        ZStack {
            Color.green
            Text("Test View with green background")
        }
    }
}
private extension SwiftUI.View {
    func referenceFrame() -> some View {
        let count = PermissionStore.shared.permissions.count
        return self.frame(width: referenceSize.width, height: referenceSize.height+CGFloat(count*60))
    }
    func referenceFrameCell() -> some View{
        return self.frame(width: referenceSize.width, height: 70)
    }
}
