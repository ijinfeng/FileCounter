import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(proj_file_counterTests.allTests),
    ]
}
#endif
