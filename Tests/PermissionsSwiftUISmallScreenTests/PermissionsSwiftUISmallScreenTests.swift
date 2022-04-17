@testable import PermissionsSwiftUI
import XCTest
import SwiftUI
import SnapshotTesting
import HealthKit

private let referenceSize = UIScreen.main.bounds.size
final class PermissionsSwiftUISmallScreenTests: XCTestCase {

}

@available(iOS 13.0, *)
struct testViewRedBG:View{
    var body: some View{
        ZStack {
            Color.red
            Text("Test View with red background")
        }
    }
}

@available(iOS 13.0, *)
struct testViewGreenBG:View{
    var body: some View{
        ZStack {
            Color.green
            Text("Test View with green background")
        }
    }
}
