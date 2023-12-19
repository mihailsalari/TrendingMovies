import Combine
import XCTest
@testable import TrendingMovies

final class APIServiceTests: XCTestCase {
    var sut: APIService!
    var urlSessionMock: MockURLSession!

    override func setUp() {
        super.setUp()
        urlSessionMock = MockURLSession()
        sut = APIService(session: urlSessionMock)
    }

    override func tearDown() {
        sut = nil
        urlSessionMock = nil
        super.tearDown()
    }

    func testRequestSuccess() {
        let expectedData = "{\"key\":\"value\"}".data(using: .utf8)
        urlSessionMock.data = expectedData
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "https://test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectation = self.expectation(description: "Successful Request")

        let _ = sut.request(urlString: "https://test.com").sink(receiveCompletion: { _ in }, receiveValue: { (data: [String: String]) in
            XCTAssertEqual(data["key"], "value")
            expectation.fulfill()
        })

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRequestFailure() {
        urlSessionMock.error = NSError(domain: "test", code: 0, userInfo: nil)
        let expectation = self.expectation(description: "Failed Request")

        let _ = sut.request(urlString: "https://test.com").sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            default:
                break
            }
        }, receiveValue: { (data: [String: String]) in })

        waitForExpectations(timeout: 5, handler: nil)
    }
}
