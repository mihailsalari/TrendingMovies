import Combine
import Foundation
@testable import TrendingMovies

final class MockNetworkService: NetworkServiceProtocol {
    var data: Data?
    var error: Error?

    func request<T: Decodable>(urlString: String, headers: [String: String]?) -> AnyPublisher<T, Error> {
        if let error = self.error {
            return Fail(error: error).eraseToAnyPublisher()
        } else if let data = self.data {
            return Just(data)
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { _ in URLError(.badServerResponse) }
                .eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
    }
}
