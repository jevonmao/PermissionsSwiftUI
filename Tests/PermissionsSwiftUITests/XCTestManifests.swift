import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(PermissionsSwiftUITests.allTests),
    ]
}
#endif
