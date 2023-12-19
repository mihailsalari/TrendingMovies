import Combine
import Foundation
@testable import TrendingMovies

final class URLSessionDataTaskMock: URLSessionDataTask {
    var resumeWasCalled = false

    override func resume() {
        resumeWasCalled = true
    }
}

final class MockingURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}

final class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func withDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        DispatchQueue.global().async {
            completionHandler(self.data, self.response, self.error)
        }
        
        
        return MockingURLSessionDataTask {
            completionHandler(self.data, nil, self.error)
        }
    }
}
