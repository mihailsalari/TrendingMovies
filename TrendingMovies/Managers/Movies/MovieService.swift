import Combine

protocol MovieServiceProtocol {
    func fetchTrendingMovies(_ endpoint: MoviesEndpointType) -> AnyPublisher<MovieResponse, Error>
    func fetchMovieDetails(_ endpoint: MoviesEndpointType, movieId: Int) -> AnyPublisher<MovieDetail, Error>
}

final class MovieService: MovieServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let apiKey: String
    private let baseURLString: String
    
    init(networkService: NetworkServiceProtocol, baseURLString: String, apiKey: String) {
        self.networkService = networkService
        self.baseURLString = baseURLString
        self.apiKey = apiKey
    }

    func fetchTrendingMovies(_ endpoint: MoviesEndpointType) -> AnyPublisher<MovieResponse, Error> {
        networkService.request(urlString: endpoint.fullURLString(from: baseURLString), headers: getHeaders())
    }
    
    func fetchMovieDetails(_ endpoint: MoviesEndpointType, movieId: Int) -> AnyPublisher<MovieDetail, Error> {
        networkService.request(urlString: endpoint.fullURLString(from: baseURLString) + "/\(movieId)", headers: getHeaders())
    }
    
    private func getHeaders() -> [String : String]? {
        ["accept": "application/json",
        "Authorization": apiKey]
    }
}
