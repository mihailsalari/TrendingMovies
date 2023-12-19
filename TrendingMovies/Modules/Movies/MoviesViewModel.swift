import Combine
import Foundation

protocol MoviesViewModelProtocol: ObservableObject {
    var movies: [Movie] { get }
    
    func loadMovies()
    func getFullPosterURL(with movie: Movie) -> URL?
    
    func releaseDate(movie: Movie) -> String
    func rating(movie: Movie) -> String 
}


final class MoviesViewModel: MoviesViewModelProtocol {
    @Published var movies: [Movie] = []
    private var cancellables = Set<AnyCancellable>()
    private let movieService: MovieServiceProtocol

    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }

    func loadMovies() {
        movieService.fetchTrendingMovies(.trending)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] movieResponse in
                      self?.movies = movieResponse.results })
            .store(in: &cancellables)
    }

    func getFullPosterURL(with movie: Movie) -> URL? {
        guard let posterPath = movie.posterPath,
              let encodedPath = posterPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        return URL(string: AppConstants.imageBaseURLString + encodedPath)
    }
    
    func releaseDate(movie: Movie) -> String {
        "Release Date: \(movie.releaseDate)"
    }
    
    func rating(movie: Movie) -> String {
        "Rating: \(movie.voteAverage) (\(movie.voteCount) votes)"
    }
}

