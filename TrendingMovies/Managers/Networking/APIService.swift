import Combine
import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(urlString: String, headers: [String: String]?) -> AnyPublisher<T, Error>
}

struct APIService: NetworkServiceProtocol {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func request<T: Decodable>(urlString: String, headers: [String: String]? = nil) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        return Future<T, Error> { promise in
            self.session.withDataTask(with: request) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        promise(.success(decoded))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }.resume()
        }.eraseToAnyPublisher()
    }
}

