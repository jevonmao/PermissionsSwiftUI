@testable import PermissionsSwiftUI
import XCTest
import SwiftUI
import SnapshotTesting
import HealthKit

private let referenceSize = UIScreen.main.bounds.size
final class PermissionsSwiftUISmallScreenTests: XCTestCase {

}

struct TestViewRedBG:View {
    @available(iOS 13.0, *)
    var body: some View{
        ZStack {
            Color.red
            Text("Test View with red background")
        }
    }
}
struct TestViewGreenBG:View {
    @available(iOS 13.0, *)
    var body: some View{
        ZStack {
            Color.green
            Text("Test View with green background")
        }
    }
}
