import Combine
import XCTest
@testable import TrendingMovies

final class MovieServiceTests: XCTestCase {
    private var sut: MovieService!
    private var mockNetworkService: MockNetworkService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = MovieService(networkService: mockNetworkService, baseURLString: "https://api.example.com", apiKey: UUID().uuidString)
        cancellables = []
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchTrendingMoviesSuccess() {
        // TODO: - temporary, we need to use mock JSON data instead of instantiating the model
        let movie = Movie(id: 1, title: "Test Movie", overview: "Overview", posterPath: nil, releaseDate: "2021-01-01", voteAverage: 8.5, voteCount: 100)
        let movieResponse = MovieResponse(page: 1, results: [movie], totalPages: 10, totalResults: 100)
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(movieResponse) {
            mockNetworkService.data = encodedData
        }
        
        let expectation = self.expectation(description: "Fetch trending movies succeeds")
        
        sut.fetchTrendingMovies(.trending)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { response in
                XCTAssertEqual(response.page, movieResponse.page)
                XCTAssertEqual(response.results.first?.title, movie.title)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchTrendingMoviesFailure() {
        let expectedError = NSError(domain: "com.yourapp.network", code: 1, userInfo: nil)
        mockNetworkService.error = expectedError

        let expectation = self.expectation(description: "Fetch trending movies fails")

        sut.fetchTrendingMovies(.trending)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error as NSError):
                    XCTAssertEqual(error, expectedError)
                    expectation.fulfill()
                default:
                    break
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFetchMovieDetailsSuccess() {
        // TODO: - temporary, we need to use mock JSON data instead of instantiating the model
        let movieDetail = MovieDetail(adult: false, backdropPath: nil, belongsToCollection: nil, budget: 0, genres: [.init(id: 1, name: "Demo")],
                                      homepage: nil, id: 123, imdbId: nil, originalLanguage: "Eng", originalTitle: "Hello", overview: "Bla bla bla",
                                      popularity: 2.0, posterPath: nil, productionCompanies: [], productionCountries: [], releaseDate: "2021-01-01", revenue: 0,
                                      runtime: nil, spokenLanguages: [], status: "", tagline: nil, title: "", video: false, voteAverage: 0, voteCount: 0)
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(movieDetail) {
            mockNetworkService.data = encodedData
        }
        
        let movieId = 123
        let expectation = self.expectation(description: "Fetch movie details succeeds")
        
        sut.fetchMovieDetails(.details, movieId: movieId)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { response in
                XCTAssertEqual(response.id, movieDetail.id)
                    expectation.fulfill()
                  })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchMovieDetailsFailure() {
        let expectedError = NSError(domain: "com.example.network", code: 1, userInfo: nil)
        mockNetworkService.error = expectedError

        let movieId = 123
        let expectation = self.expectation(description: "Fetch movie details fails")

        sut.fetchMovieDetails(.details, movieId: movieId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error as NSError):
                    XCTAssertEqual(error, expectedError)
                    expectation.fulfill()
                default:
                    break
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
