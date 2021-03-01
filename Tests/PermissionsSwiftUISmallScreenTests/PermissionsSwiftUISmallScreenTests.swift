@testable import PermissionsSwiftUI
import XCTest
import SwiftUI
import SnapshotTesting
import HealthKit

fileprivate let referenceSize = UIScreen.main.bounds.size
final class PermissionsSwiftUISmallScreenTests: XCTestCase {
    let placeholderText = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec congue metus.
"""
    override func setUpWithError() throws {
        PermissionStore.resetPermissionsModelStore()
    }
    func testPermissionStoreCurrentPermissionGet(){
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
        let healthPermission = PermissionType.health().currentPermission
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
        XCTAssertEqual(healthPermission, JMPermission(
                        imageIcon: AnyView(Image(systemName: "heart.fill")),
                        title: "Health",
                        description: "Allow to access your health information",
                        authorized: false))
        //Additional test for failing case
        XCTAssertNotEqual(notificationPermission, JMPermission(
            imageIcon: AnyView(Image(systemName: "bell.fill")),
            title: "Test_Notification",
            description: "Allow to send notifications", authorized: false
        ))
        
    }
    func testPermissionStoreAllPermissions(){
        let permissionType = PermissionType.camera
        var testingPermissions: [PermissionType] = [.camera, .bluetooth]
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: testingPermissions)
        XCTAssertEqual(permissionType.permissions.description, testingPermissions.description)
        testingPermissions = PermissionType.allCases
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: testingPermissions)
        XCTAssertEqual(permissionType.permissions.description, testingPermissions.description)
    }
    func testPermissionStorePermissionManager(){
        let permissionTypes = PermissionType.allCases
        UNUserNotificationCenter.isTestingMode = true
        for permission in permissionTypes{
            let permissionManagerString = String(describing: permission.getPermissionManager()).lowercased()
            let permissionRawValueString = permission.rawValue.lowercased()
            XCTAssert(permissionManagerString.contains("permissionmanager"))
            XCTAssert(permissionManagerString.contains(permissionRawValueString))
        }
    }
    
    func testLocationPermissionManager(){
        let manager = MockCLLocationManager()
        let JMManager = JMLocationPermissionManager(locationManager: manager)
        let JMAlwaysManager = JMLocationAlwaysPermissionManager(locationManager: manager)
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
    func setupHealthPermissionStore() -> (MockHealthManager, JMHealthPermissionManager){
        let mockManager = MockHealthManager()
        MockHealthManager.healthDataAvailableOverride = true
        let manager = JMHealthPermissionManager(healthManager: mockManager)
        let quantityType = Set([HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
                                HKSampleType.quantityType(forIdentifier: .bodyFatPercentage)!,
                                HKSampleType.quantityType(forIdentifier: .bloodGlucose)!])
        let healthPermission = PermissionType.health(categories: .init(readAndWrite: quantityType))
        PermissionStore.shared.updateStore(property: {$0.permissions.append($1)}, value: healthPermission)
        return (mockManager, manager)
    }
    func testHealthManagerAuthNotDetermined(){
        let (mockManager, manager) = setupHealthPermissionStore()
        mockManager.authStatusOverride = .notDetermined
        XCTAssertEqual(manager.authorizationStatus, .notDetermined)
    }
    func testHealthManagerAuthAuthorized(){
        let (mockManager, manager) = setupHealthPermissionStore()
        mockManager.authStatusOverride = .authorized
        XCTAssertEqual(manager.authorizationStatus, .authorized)
    }
    func testHealthManagerAuthDenied(){
        let (mockManager, manager) = setupHealthPermissionStore()
        mockManager.authStatusOverride = .denied
        XCTAssertEqual(manager.authorizationStatus, .denied)
    }
    func testHealthManagerReqestReadWrite() {
        let (manager, sharedType, mockManager) = setupHealthPermissionReadWrite()
        let readType = Array(Array(sharedType)[0..<1])
        let writeType = Array(Array(sharedType)[1...])
        let healthPermission = PermissionType.health(categories: .init(read: Set(readType),
                                                                    write: Set(writeType)))
        PermissionStore.shared.updateStore(property: {$0.permissions=[$1]}, value: healthPermission)
        manager.requestPermission{_=$0}
        XCTAssertEqual(mockManager.requestedPermissions?.readPermissions, Set(readType))
        XCTAssertEqual(mockManager.requestedPermissions?.writePermissions, Set(writeType))
    func testHealthManagerAuthMixedAuthorized(){
        let (mockManager, manager) = setupHealthPermissionStore()
        mockManager.authStatusOverride = .mixedAuthorized
        XCTAssertEqual(manager.authorizationStatus, .authorized)
    }
    func testHealthManagerAuthMixedDenied(){
        let (mockManager, manager) = setupHealthPermissionStore()
        mockManager.authStatusOverride = .mixedDenied
        XCTAssertEqual(manager.authorizationStatus, .denied)
    }
    func setupHealthPermissionReadWrite() -> (JMHealthPermissionManager, Set<HKSampleType>) {
        let sharedType = Set([HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
                              HKSampleType.quantityType(forIdentifier: .bodyFatPercentage)!,
                              HKSampleType.quantityType(forIdentifier: .bloodGlucose)!])
        let healthPermission = PermissionType.health(categories: .init(readAndWrite: sharedType))
        let mockManager = MockHealthManager()
        let manager = JMHealthPermissionManager(healthManager: mockManager)
        PermissionStore.shared.updateStore(property: {$0.permissions=[$1]}, value: healthPermission)
        return (manager, sharedType)
    }
    func testHealthManagerReadWriteSame(){
        let (manager, sharedType) = setupHealthPermissionReadWrite()
        XCTAssertEqual(manager.healthPermission?.readPermissions, sharedType)
        XCTAssertEqual(manager.healthPermission?.writePermissions, sharedType)
    }
    func testHealthManagerReadWriteDifferent(){
        let (manager, sharedType) = setupHealthPermissionReadWrite()
        let readType = Array(Array(sharedType)[0..<1])
        let writeType = Array(Array(sharedType)[1...])
        let healthPermission = PermissionType.health(categories: .init(read: Set(readType),
                                                                       write: Set(writeType)))
        PermissionStore.shared.updateStore(property: {$0.permissions=[$1]}, value: healthPermission)
        XCTAssertEqual(manager.healthPermission?.readPermissions, Set(readType))
        XCTAssertEqual(manager.healthPermission?.writePermissions, Set(writeType))
    }
    func testHealthManagerUnavailableResults(){
        let (_, manager) = setupHealthPermissionStore()
        MockHealthManager.healthDataAvailableOverride = false
        let expectation = self.expectation(description: "Wait for unavailable result")
        var authorizationRequestResult: Bool?
        manager.requestPermission{
            authorizationRequestResult = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        XCTAssertFalse(authorizationRequestResult ?? true)
    }
    func testHealthManagerAuthedResults(){
        let (mockManager, manager) = setupHealthPermissionStore()
        mockManager.requestSuccessOverride = true
        let expectation = self.expectation(description: "Wait for true result")
        var authorizationRequestResult: Bool?
        manager.requestPermission{
            authorizationRequestResult = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        XCTAssert(authorizationRequestResult ?? false)
    }
    func testHealthManagerDeniedResults(){
        let (mockManager, manager) = setupHealthPermissionStore()
        MockHealthManager.healthDataAvailableOverride = true
        mockManager.requestSuccessOverride = false
        let expectation = self.expectation(description: "Wait for false result")
        var authorizationRequestResult: Bool?
        manager.requestPermission{
            authorizationRequestResult = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        XCTAssertFalse(authorizationRequestResult ?? true)
    }
    func testHealthManagerNoHealthPermission(){
        let mockManager = MockHealthManager()
        let manager = JMHealthPermissionManager(healthManager: mockManager)
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: [PermissionType]())
        XCTAssertNil(manager.healthPermission)
        XCTAssertEqual(manager.authorizationStatus, .notDetermined)
        let expectation = self.expectation(description: "Wait for true result")
        var authorizationRequestResult: Bool?
        manager.requestPermission{
            authorizationRequestResult = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        XCTAssert(authorizationRequestResult ?? false)
    }
    func testHealthManagerEmptyPermissions(){
        let mockManager = MockHealthManager()
        let manager = JMHealthPermissionManager(healthManager: mockManager)
        PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: [.camera,.calendar])
        XCTAssertNil(manager.healthPermission)
        XCTAssertEqual(manager.authorizationStatus, .notDetermined)
        let expectation = self.expectation(description: "Wait for true result")
        var authorizationRequestResult: Bool?
        manager.requestPermission{
            authorizationRequestResult = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        XCTAssert(authorizationRequestResult ?? false)
    }
    func testPermissionManagers() {
        DispatchQueue.main.async {
            JMContactsPermissionManager.shared.requestPermission{
                XCTAssertTrue($0)
            }
            JMMicrophonePermissionManager.shared.requestPermission{
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
            PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: PermissionType.allCases)
            PermissionStore.shared.updateStore(property: {$0.autoCheckModalAuth=$1}, value: false)
            let view = ModalView(showModal: .constant(true))
            assertSnapshot(matching: view.referenceFrame(), as: .image)
        }
    }
    func testModalViewSnapshot14_5(){
        if #available(iOS 14.5, *) {
            let view = ModalView(showModal: .constant(true))
            PermissionStore.shared.updateStore(property: {$0.permissions=$1}, value: PermissionType.allCases)
            assertSnapshot(matching: view.referenceFrame(), as: .image)
        }
    }
    
    func testCustomizeHeaderSnapshot(){
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
    
    func testMainViewShouldShowPermissionTrue(){
        let permissions: [PermissionType] = [.calendar, .camera, .microphone]
        let mainView = MainView(for: AnyView(EmptyView()), show: .constant(false), permissionsToAsk: permissions)
        XCTAssert(mainView.shouldShowPermission.wrappedValue)
    }
    func testMainViewShouldShowPermissionEmpty(){
        let permissions: [PermissionType] = []
        let mainView = MainView(for: AnyView(EmptyView()), show: .constant(false), permissionsToAsk: permissions)
        XCTAssertFalse(mainView.shouldShowPermission.wrappedValue)
    }
    func testMainViewShouldShowPermissionDisabled(){
        var permissions: [PermissionType] = [.calendar, .camera, .microphone]
        PermissionStore.shared.updateStore(property: {$0.autoCheckModalAuth=$1}, value: false)
        let mainView = MainView(for: AnyView(EmptyView()), show: .constant(false), permissionsToAsk: permissions)
        XCTAssert(mainView.shouldShowPermission.wrappedValue)
        permissions = []
        let mainView2 = MainView(for: AnyView(EmptyView()), show: .constant(false), permissionsToAsk: permissions)
        XCTAssert(mainView2.shouldShowPermission.wrappedValue)
    }
    func testBindingCombineExtension(){
        let trueBinding = Binding.constant(true)
        let falseBinding = Binding.constant(false)
        XCTAssert(trueBinding.combine(with: .constant(true)).wrappedValue)
        XCTAssertFalse(trueBinding.combine(with: falseBinding).wrappedValue)
        XCTAssertFalse(falseBinding.combine(with: .constant(false)).wrappedValue)
    }
    func testAlertViewSinglePermission(){
        let view = EmptyView()
            .background(Color.red.edgesIgnoringSafeArea(.all))
            .JMAlert(showModal: .constant(true), for: [.bluetooth], autoCheckAuthorization: false)
        assertSnapshot(matching: view, as: .image)
    }
    func testAlertViewTwoPermissions(){
        let view = EmptyView()
            .background(Color.red.edgesIgnoringSafeArea(.all))
            .JMAlert(showModal: .constant(true), for: [.bluetooth, .camera], autoCheckAuthorization: false)
        assertSnapshot(matching: view, as: .image)
    }
    func testAlertViewThreePermissions(){
        let view = EmptyView()
            .background(Color.red.edgesIgnoringSafeArea(.all))
            .JMAlert(showModal: .constant(true), for: [.bluetooth, .camera, .location], autoCheckAuthorization: false)
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
        return self.frame(width: referenceSize.width, height: referenceSize.height+CGFloat(count*70))
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
