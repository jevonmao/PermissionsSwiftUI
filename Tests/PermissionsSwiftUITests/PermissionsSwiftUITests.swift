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

fileprivate let referenceSize = UIScreen.main.bounds.size
#warning("Write unit tests")
@available(iOS 13.0, tvOS 13.0, *)
final class PermissionsSwiftUITests: XCTestCase {
//    let placeholderText = """
//Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec congue metus.
//"""
//    func testPermissionStoreCurrentPermissionGet(){
//        var store = PermissionComponentsStore()
//        if #available(iOS 14.5, *) {
//            let trackingPermission = store.getPermissionComponent(for: .tracking, modify: {_ in })
//            XCTAssertEqual(trackingPermission, JMPermission(
//                imageIcon: AnyView(Image(systemName: "person.circle.fill")),
//                title: "Tracking",
//                description: "Allow to track your data", authorized: false
//            ))
//        }
//        let photoPermission = store.getPermissionComponent(for: .photo, modify: {_ in })
//        let cameraPermission = store.getPermissionComponent(for: .camera, modify: {_ in })
//        let locationPermission = store.getPermissionComponent(for: .location, modify: {_ in })
//        let reminderPermission = store.getPermissionComponent(for: .reminders, modify: {_ in })
//        let speechPermission = store.getPermissionComponent(for: .speech, modify: {_ in })
//        let bluetoothPermission = store.getPermissionComponent(for: .bluetooth, modify: {_ in })
//        let calendarPermission = store.getPermissionComponent(for: .calendar, modify: {_ in })
//        let contactsPermission = store.getPermissionComponent(for: .contacts, modify: {_ in })
//        let locationAlwaysPermission = store.getPermissionComponent(for: .locationAlways, modify: {_ in })
//        let microphonePermission = store.getPermissionComponent(for: .microphone, modify: {_ in })
//        let notificationPermission = store.getPermissionComponent(for: .notification, modify: {_ in })
//        let healthPermission = store.getPermissionComponent(for: .health, modify: {_ in })
//        let musicPermission = store.getPermissionComponent(for: .music, modify: {_ in })
//        XCTAssertEqual(photoPermission, JMPermission(
//            imageIcon: AnyView(Image(systemName: "photo")),
//            title: "Photo Library",
//            description: "Allow to access your photos", authorized: false
//        ))
//        XCTAssertEqual(cameraPermission, JMPermission(
//                        imageIcon: AnyView(Image(systemName: "camera.fill")),
//                        title: "Camera",
//                        description: "Allow to use your camera", authorized: false))
//        XCTAssertEqual(locationPermission, JMPermission(
//            imageIcon: AnyView(Image(systemName: "location.fill.viewfinder")),
//            title: "Location",
//            description: "Allow to access your location", authorized: false
//        ))
//        XCTAssertEqual(reminderPermission, JMPermission(
//            imageIcon: AnyView(Image(systemName: "list.bullet.rectangle")),
//            title: "Reminders",
//            description: "Allow to access your reminders", authorized: false
//        ))
//        XCTAssertEqual(speechPermission, JMPermission(
//            imageIcon: AnyView(Image(systemName: "rectangle.3.offgrid.bubble.left.fill")),
//            title: "Speech",
//            description: "Allow to access speech recognition", authorized: false
//        ))
//        XCTAssertEqual(bluetoothPermission, JMPermission(
//            imageIcon: AnyView(Image(systemName: "wave.3.left.circle.fill")),
//            title: "Bluetooth",
//            description: "Allow to use bluetooth", authorized: false
//        ))
//        XCTAssertEqual(calendarPermission, JMPermission(
//            imageIcon: AnyView(Image(systemName: "calendar")),
//            title: "Calendar",
//            description: "Allow to access calendar", authorized: false
//        ))
//        XCTAssertEqual(contactsPermission, JMPermission(
//            imageIcon: AnyView(Image(systemName: "book.fill")),
//            title: "Contacts",
//            description: "Allow to access your contacts", authorized: false
//        ))
//        XCTAssertEqual(locationAlwaysPermission, JMPermission(
//            imageIcon: AnyView(Image(systemName: "location.fill.viewfinder")),
//            title: "Location Always",
//            description: "Allow to access your location", authorized: false
//        ))
//        XCTAssertEqual(microphonePermission, JMPermission(
//            imageIcon: AnyView(Image(systemName: "mic.fill")),
//            title: "Microphone",
//            description: "Allow to record with microphone", authorized: false
//        ))
//        XCTAssertEqual(notificationPermission, JMPermission(
//            imageIcon: AnyView(Image(systemName: "bell.fill")),
//            title: "Notification",
//            description: "Allow to send notifications", authorized: false
//        ))
//        XCTAssertEqual(healthPermission, JMPermission(
//                        imageIcon: AnyView(Image(systemName: "heart.fill")),
//                        title: "Health",
//                        description: "Allow to access your health information",
//                        authorized: false))
//        XCTAssertEqual(musicPermission, JMPermission(imageIcon: Image(systemName: "music.note.list").typeErased(),
//                                                     title: "Music",
//                                                     description: "Allow to control audio playback"))
//    }

//    func setupHealthPermissionStore(quantityType: Set<HKSampleType> = Set([HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
//                                                        HKSampleType.quantityType(forIdentifier: .bodyFatPercentage)!,
//                                                        HKSampleType.quantityType(forIdentifier: .bloodGlucose)!])) -> (MockHealthManager, JMHealthPermissionManager){
//        let mockManager = MockHealthManager()
//        MockHealthManager.healthDataAvailableOverride = true
//        let healthPermission = PermissionType.health(categories: .init(readAndWrite: quantityType))
//        let manager = JMHealthPermissionManager(healthManager: mockManager, permissionType: healthPermission)
//        return (mockManager, manager)
//    }
//    func testHealthManagerAuthNotDetermined(){
//        let (mockManager, manager) = setupHealthPermissionStore()
//        mockManager.authStatusOverride = .notDetermined
//        XCTAssertEqual(manager.authorizationStatus, .notDetermined)
//    }
//    func testHealthManagerAuthAuthorized(){
//        let (mockManager, manager) = setupHealthPermissionStore()
//        mockManager.authStatusOverride = .authorized
//        XCTAssertEqual(manager.authorizationStatus, .authorized)
//    }
//    func testHealthManagerAuthDenied(){
//        let (mockManager, manager) = setupHealthPermissionStore()
//        mockManager.authStatusOverride = .denied
//        XCTAssertEqual(manager.authorizationStatus, .denied)
//    }
//    func testHealthManagerAuthMixedAuthorized(){
//        let (mockManager, manager) = setupHealthPermissionStore()
//        mockManager.authStatusOverride = .mixedAuthorized
//        XCTAssertEqual(manager.authorizationStatus, .authorized)
//    }
//    func testHealthManagerAuthMixedDenied(){
//        let (mockManager, manager) = setupHealthPermissionStore()
//        mockManager.authStatusOverride = .mixedDenied
//        XCTAssertEqual(manager.authorizationStatus, .denied)
//    }
//    func testHealthManagerReqestReadWrite() {
//        let (manager, sharedType, mockManager) = setupHealthPermissionReadWrite()
//        let readType = Array(Array(sharedType)[0..<1])
//        let writeType = Array(Array(sharedType)[1...])
//        let healthPermission = PermissionType.health(categories: .init(read: Set(readType),
//                                                                    write: Set(writeType)))
//        manager.requestPermission{_,_ in}
//        XCTAssertEqual(mockManager.requestedPermissions?.readPermissions, Set(readType))
//        XCTAssertEqual(mockManager.requestedPermissions?.writePermissions, Set(writeType))
//
//    }
//    func setupHealthPermissionReadWrite() -> (JMHealthPermissionManager, Set<HKSampleType>, MockHealthManager) {
//        let sharedType = Set([HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
//                              HKSampleType.quantityType(forIdentifier: .bodyFatPercentage)!,
//                              HKSampleType.quantityType(forIdentifier: .bloodGlucose)!])
//        let healthPermission = PermissionType.health(categories: .init(readAndWrite: sharedType))
//        let mockManager = MockHealthManager()
//        let manager = JMHealthPermissionManager(healthManager: mockManager, permissionType: healthPermission)
//        return (manager, sharedType, mockManager)
//    }
//    func testHealthManagerReadWriteSame(){
//        let (manager, sharedType, _) = setupHealthPermissionReadWrite()
//        XCTAssertEqual(manager.healthPermission?.readPermissions, sharedType)
//        XCTAssertEqual(manager.healthPermission?.writePermissions, sharedType)
//    }
//    func testHealthManagerReadWriteDifferent(){
//        let (manager, sharedType, _) = setupHealthPermissionReadWrite()
//        let readType = Array(Array(sharedType)[0..<1])
//        let writeType = Array(Array(sharedType)[1...])
//        let healthPermission = PermissionType.health(categories: .init(read: Set(readType),
//                                                                       write: Set(writeType)))
//        XCTAssertEqual(manager.healthPermission?.readPermissions, Set(readType))
//        XCTAssertEqual(manager.healthPermission?.writePermissions, Set(writeType))
//    }
//    func testHealthManagerUnavailableResults(){
//        let (_, manager) = setupHealthPermissionStore()
//        MockHealthManager.healthDataAvailableOverride = false
//        let expectation = self.expectation(description: "Wait for unavailable result")
//        var authorizationRequestResult: Bool?
//        manager.requestPermission{authorized, _ in
//            authorizationRequestResult = authorized
//            expectation.fulfill()
//        }
//        waitForExpectations(timeout: 10)
//        XCTAssertFalse(authorizationRequestResult ?? true)
//    }
//    func testHealthManagerAuthedResults(){
//        let (mockManager, manager) = setupHealthPermissionStore()
//        mockManager.requestSuccessOverride = true
//        let expectation = self.expectation(description: "Wait for true result")
//        var authorizationRequestResult: Bool?
//        manager.requestPermission{authorized, _ in
//            authorizationRequestResult = authorized
//            expectation.fulfill()
//        }
//        waitForExpectations(timeout: 10)
//        XCTAssert(authorizationRequestResult ?? false)
//    }
//    func testHealthManagerDeniedResults(){
//        let (mockManager, manager) = setupHealthPermissionStore()
//        MockHealthManager.healthDataAvailableOverride = true
//        mockManager.requestSuccessOverride = false
//        let expectation = self.expectation(description: "Wait for false result")
//        var authorizationRequestResult: Bool?
//        manager.requestPermission{authorized, _ in
//            authorizationRequestResult = authorized
//            expectation.fulfill()
//        }
//        waitForExpectations(timeout: 10)
//        XCTAssertFalse(authorizationRequestResult ?? true)
//    }
//    func testHealthManagerNoHealthPermission(){
//        let mockManager = MockHealthManager()
//        let manager = JMHealthPermissionManager(healthManager: mockManager, permissionType: .health(categories: nil))
//        XCTAssertNil(manager.healthPermission)
//        XCTAssertEqual(manager.authorizationStatus, .notDetermined)
//        let expectation = self.expectation(description: "Wait for true result")
//        var authorizationRequestResult: Bool?
//        manager.requestPermission{authorized, _ in
//            authorizationRequestResult = authorized
//            expectation.fulfill()
//        }
//        waitForExpectations(timeout: 10)
//        XCTAssert(authorizationRequestResult ?? false)
//    }
//    func testHealthManagerEmptyPermissions(){
//        let mockManager = MockHealthManager()
//        let manager = JMHealthPermissionManager(healthManager: mockManager, permissionType: .health(categories: nil))
//        XCTAssertNil(manager.healthPermission)
//        XCTAssertEqual(manager.authorizationStatus, .notDetermined)
//        let expectation = self.expectation(description: "Wait for true result")
//        var authorizationRequestResult: Bool?
//        manager.requestPermission{authorized, _ in
//            authorizationRequestResult = authorized
//            expectation.fulfill()
//        }
//        waitForExpectations(timeout: 10)
//        XCTAssert(authorizationRequestResult ?? false)
//    }
//    func testPermissionManagers() {
//        DispatchQueue.main.async {
//            JMContactsPermissionManager.shared.requestPermission{authorized, _ in
//                XCTAssertTrue(authorized)
//            }
//            JMMicrophonePermissionManager.shared.requestPermission{authorized, _ in
//                XCTAssertTrue(authorized)
//            }
//            JMBluetoothPermissionManager.shared.requestPermission{authorized, _ in
//                XCTAssertTrue(authorized)
//            }
//            JMCalendarPermissionManager.shared.requestPermission{authorized, _ in
//                XCTAssertTrue(authorized)
//            }
//            JMCameraPermissionManager.shared.requestPermission{authorized, _ in
//                XCTAssertTrue(authorized)
//            }
//            JMMotionPermissionManager.shared.requestPermission{authorized, _ in
//                XCTAssertTrue(authorized)
//            }
//
//            JMRemindersPermissionManager.shared.requestPermission{authorized, _ in
//                XCTAssertTrue(authorized)
//            }
//            JMSpeechPermissionManager.shared.requestPermission{authorized, _ in
//                XCTAssertTrue(authorized)
//            }
//            if #available(iOS 14.5, *) {
//                JMTrackingPermissionManager.shared.requestPermission{authorized, _ in
//                    XCTAssertTrue(authorized)
//                }
//            }
//        }
//
//    }
//    func permissionManagerMethod(for permission:PermissionType){
//        switch permission {
//        default:
//            let expectation = self.expectation(description: "Requesting permission access")
//            var permissionGranted:Bool?
//            DispatchQueue.main.async {
//                JMRemindersPermissionManager.shared.requestPermission{authorized, _ in
//                    permissionGranted = authorized
//                    expectation.fulfill()
//                }
//            }
//            waitForExpectations(timeout: 5, handler: nil)
//            XCTAssertTrue(permissionGranted ?? false)
//        }
//
//    }
//    func testPhotoPermission(){
//        let photoPermissionManager = JMPhotoPermissionManager(photoLibrary: MockPhotoManager.self)
//        photoPermissionManager.requestPermission{authorized, _ in
//            XCTAssert(authorized)
//        }
//    }
//    func testModalViewSnapshot(){
//        if #available(iOS 14, *) {
//            let store = PermissionStore()
//            store.permissions = [PermissionManager].allCases
//            store.configStore.autoCheckAuth = false
//            let view = ModalView(showModal: .constant(true)).withEnvironmentObjects(store: store, permissionStyle: .modal)
//            assertSnapshot(matching: view.referenceFrame(count: store.permissions.count), as: .image(precision: 0.99))
//        }
//    }
//
//    func testCustomizeHeaderSnapshot(){
//        let newHeader = "Permissions Request"
//        let store = PermissionStore()
//        _ = ModalViewWrapper(for: Color.red, showing: .constant(true), store: store)
//            .changeHeaderTo(newHeader)
//            .changeHeaderDescriptionTo(placeholderText)
//            .changeBottomDescriptionTo(placeholderText)
//            .referenceFrame(count: 0)
//
//        XCTAssertEqual(newHeader, store.configStore.mainTexts.headerText)
//        XCTAssertEqual(placeholderText, store.configStore.mainTexts.headerDescription)
//        XCTAssertEqual(placeholderText, store.configStore.mainTexts.bottomDescription)
//        let view = ModalView(showModal: .constant(true)).withEnvironmentObjects(store: store, permissionStyle: .modal)
//        assertSnapshot(matching: view, as: .image)
//
//    }
//    func testPermissionCell(){
//        for permission in [PermissionManager].allCases {
//            let currentPermission = PermissionStore().permissionComponentsStore.getPermissionComponent(for: permission.permissionType, modify: {_ in})
//            let views = getPermissionView(for: permission)
//            for i in views{
//                assertSnapshot(matching: i, as: .image(precision: 0.99))
//            }
//        }
//    }
//    func getPermissionView(for permission: PermissionManager) -> [AnyView]{
//        switch permission {
//        default:
//            let views:[AnyView] = AllowButtonStatus.allCases.map{
//                let view = PermissionSectionCell(permissionManager: permission, allowButtonStatus: $0, showing: .constant(true))
//                    .withEnvironmentObjects(store: PermissionStore(), permissionStyle: .modal)
//                    .referenceFrameCell()
//                return AnyView(view)
//            }
//            return views
//
//        }
//    }
//    func testStateChangeClosures(){
//        XCTAssertNil(store.onAppear)
//        XCTAssertNil(store.onDisappear)
//        var testString = ""
//        let onAppear = {
//            testString = "appeared"
//        }
//        let onDisappear = {
//            testString = "disappeared"
//        }
//        _ = EmptyView().JMModal(showModal: .constant(true), for: [], onAppear: onAppear, onDisappear: onDisappear)
//        XCTAssertNotNil(store.onAppear)
//        XCTAssertNotNil(store.onAppear)
//        ModalMainView.testCallOnAppear()
//        XCTAssertEqual(testString, "appeared")
//        ModalMainView.testCallOnDisappear()
//        XCTAssertEqual(testString, "disappeared")
//    }
//    func testNotificationPermission(){
//        let mockManager = MockNotificationManager()
//        var notificationManager = JMNotificationPermissionManager(notificationManager: mockManager)
//        notificationManager.requestPermission{authorized, _ in
//            XCTAssertTrue(authorized)
//
//        }
//        var status = notificationManager.authorizationStatus
//        XCTAssertEqual(status, .authorized)
//
//        mockManager.authStatus = .denied
//        notificationManager = JMNotificationPermissionManager(notificationManager: mockManager)
//        notificationManager.requestPermission{authorized, _ in
//            XCTAssertFalse(authorized)
//        }
//        status = notificationManager.authorizationStatus
//        XCTAssertEqual(status, .denied)
//    }
//
//    func testMainViewShouldShowPermissionTrue(){
//        let store = PermissionStore()
//        store.permissions = [.calendar]
//        let mainView = ModalViewWrapper(for: EmptyView(), showing: .constant(true), store: store)
//        XCTAssert(mainView.shouldShowPermission.wrappedValue)
//    }
//    func testModalShouldShowPermissionLegacyTrue(){
//        let store = PermissionStore()
//        store.autoCheckAlertAuth = true
//        let mainView = ModalViewWrapper(for: EmptyView(), showing: .constant(true), store: store)
//        XCTAssert(mainView.shouldShowPermission.wrappedValue)
//        store.autoCheckAlertAuth = false
//        store.autoCheckModalAuth = true
//    func testMainViewShouldShowPermissionEmpty(){
//        let permissions: [PermissionType] = []
//        let mainView = ModalViewWrapper(for: AnyView(EmptyView()), permissionsToAsk: permissions)
//        XCTAssertFalse(mainView.shouldShowPermission.wrappedValue)
//    }
//    func testMainViewShouldShowPermissionDisabled(){
//        var permissions: [PermissionType] = [.calendar, .camera, .microphone]
//        store.updateStore(property: {$0.autoCheckModalAuth=$1}, value: false)
//        let mainView = ModalViewWrapper(for: AnyView(EmptyView()), permissionsToAsk: permissions)
//        XCTAssert(mainView.shouldShowPermission.wrappedValue)
//        permissions = []
//        let mainView2 = ModalViewWrapper(for: AnyView(EmptyView()), permissionsToAsk: permissions)
//        XCTAssert(mainView2.shouldShowPermission.wrappedValue)
//    }
    func testBindingCombineExtension(){
        let trueBinding = Binding.constant(true)
        let falseBinding = Binding.constant(false)
        XCTAssert(trueBinding.combine(with: .constant(true)).wrappedValue)
        XCTAssertFalse(trueBinding.combine(with: falseBinding).wrappedValue)
        XCTAssertFalse(falseBinding.combine(with: .constant(false)).wrappedValue)
    }

    func testAllowButtonAltLabel() {
        var store = PermissionStore()
        let normalView = PermissionSectionCell(permissionManager: .calendar,
                                               showing: .constant(true))
                            .environmentObject(store)
                            .environmentObject(PermissionSchemaStore(store: store,
                                                                     permissionViewStyle: .modal))
        assertSnapshot(matching: normalView, as: .image(precision: 0.99))
        store.configStore.mainTexts.useAltButtonLabel = true
        let altView = PermissionSectionCell(permissionManager: .calendar,
                                            showing: .constant(true))
                            .environmentObject(store)
                            .environmentObject(PermissionSchemaStore(store: store,
                                                                     permissionViewStyle: .modal))
        assertSnapshot(matching: altView, as: .image(precision: 0.99))
    }


//    func testAlertViewSinglePermission(){
//        store.updateStore(property: {$0.autoCheckAlertAuth=$1}, value: false)
//        let view = EmptyView()
//            .background(Color.red.edgesIgnoringSafeArea(.all))
//            .JMAlert(showModal: .constant(true), for: [.bluetooth])
//        assertSnapshot(matching: view, as: .image)
//    }
//    func testAlertViewTwoPermissions(){
//        store.updateStore(property: {$0.autoCheckAlertAuth=$1}, value: false)
//        let view = EmptyView()
//            .background(Color.red.edgesIgnoringSafeArea(.all))
//            .JMAlert(showModal: .constant(true), for: [.bluetooth, .camera])
//        assertSnapshot(matching: view, as: .image)
//    }
//    func testAlertViewThreePermissions(){
//        store.updateStore(property: {$0.autoCheckAlertAuth=$1}, value: false)
//        let view = EmptyView()
//            .background(Color.red.edgesIgnoringSafeArea(.all))
//            .JMAlert(showModal: .constant(true), for: [.bluetooth, .camera, .location])
//        assertSnapshot(matching: view, as: .image)
//    }
//    func testAlertViewInitializers(){
//        store.updateStore(property: {$0.autoCheckAlertAuth=$1}, value: false)
//        let view1 = EmptyView()
//            .background(Color.red.edgesIgnoringSafeArea(.all))
//            .JMAlert(showModal: .constant(true), for: [.bluetooth])
//        assertSnapshot(matching: view1, as: .image)
//        let view2 = EmptyView()
//            .background(Color.red.edgesIgnoringSafeArea(.all))
//            .JMAlert(showModal: .constant(true), for: [.bluetooth], autoDismiss: true)
//        assertSnapshot(matching: view2, as: .image)
//        let view3 = EmptyView()
//            .background(Color.red.edgesIgnoringSafeArea(.all))
//            .JMAlert(showModal: .constant(true), for: [.bluetooth], autoDismiss: false)
//        assertSnapshot(matching: view3, as: .image)
//        let view4 = EmptyView()
//            .background(Color.red.edgesIgnoringSafeArea(.all))
//            .JMAlert(showModal: .constant(true), for: [.bluetooth], autoDismiss: true, autoCheckAuthorization: false)
//        assertSnapshot(matching: view4, as: .image)
//        let view5 = EmptyView()
//            .background(Color.red.edgesIgnoringSafeArea(.all))
//            .JMAlert(showModal: .constant(true), for: [.bluetooth], autoDismiss: true, autoCheckAuthorization: false)
//        assertSnapshot(matching: view5, as: .image)
//        let view6 = EmptyView()
//            .background(Color.red.edgesIgnoringSafeArea(.all))
//            .JMAlert(showModal: .constant(true), for: [.bluetooth], onAppear: {}, onDisappear: {})
//        assertSnapshot(matching: view6, as: .image)
//        let view7 = EmptyView()
//            .background(Color.red.edgesIgnoringSafeArea(.all))
//            .JMAlert(showModal: .constant(true),
//                     for: [.bluetooth],
//                     autoDismiss: false,
//                     autoCheckAuthorization: false,
//                     onAppear: {},
//                     onDisappear: {})
//        assertSnapshot(matching: view7, as: .image)
//    }
//    func testAlertViewAutpDismissInit(){
//
//    }
//    func testPermissionSectionButtonAuthorized(){
//        let permission = PermissionType.camera
//
//        let sectionCell = PermissionSectionCell(permission: permission,
//                                                showModal: .constant(false), isAlert: false)
//        let queue = DispatchQueue(label: "testPermissionSectionHandling")
//        sectionCell.handleButtonState(for: true)
//        queue.sync {}
//        XCTAssert(permission.currentPermission.authorized)
//    }
//    func testPermissionSectionButtonDenied(){
//        let permission = PermissionType.camera
//
//        let sectionCell = PermissionSectionCell(permission: permission,
//                                                showModal: .constant(false), isAlert: false)
//        let queue = DispatchQueue(label: "testPermissionSectionHandling")
//        sectionCell.handleButtonState(for: false)
//        queue.sync {}
//        XCTAssertFalse(permission.currentPermission.authorized)
//    }
//    func testAlertPermissionSectionButtonAuthorized(){
//        let permission = PermissionType.camera
//
//        let sectionCell = PermissionSectionCell(permission: permission,
//                                                showModal: .constant(false), isAlert: true)
//        let queue = DispatchQueue(label: "testPermissionSectionHandling")
//        sectionCell.handleButtonState(for: true)
//        queue.sync {}
//        XCTAssert(permission.currentPermission.authorized)
//    }
//    func testAlertPermissionSectionButtonDenied(){
//        let permission = PermissionType.camera
//
//        let sectionCell = PermissionSectionCell(permission: permission,
//                                                showModal: .constant(false), isAlert: true)
//        let queue = DispatchQueue(label: "testPermissionSectionHandling")
//        sectionCell.handleButtonState(for: false)
//        queue.sync {}
//        XCTAssertFalse(permission.currentPermission.authorized)
//    }
//    static var allTests = [
//        ("testPermissionManagers", testPermissionManagers),
//        ("testLocationPermissionManager",testLocationPermissionManager)
//    ]
}
@available(iOS 13.0, tvOS 13.0, *)

struct testViewRedBG:View{
    var body: some View{
        ZStack {
            Color.red
            Text("Test View with red background")
        }
    }
}
@available(iOS 13.0, tvOS 13.0, *)

struct testViewGreenBG:View{
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
    static var modelName: DeviceType{
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
