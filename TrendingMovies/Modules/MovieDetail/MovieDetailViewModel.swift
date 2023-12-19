import Combine
import SwiftUI

final class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    private let movieService: MovieServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private let movieId: Int
    
    init(movieService: MovieServiceProtocol, movieId: Int) {
        self.movieService = movieService
        self.movieId = movieId
    }


    func loadMovieDetails() {
        movieService.fetchMovieDetails(.details, movieId: movieId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] details in
                self?.movieDetail = details
            })
            .store(in: &cancellables)
    }
    
    func getFullPosterURL(with posterPath: String?) -> URL? {
        guard let posterPath = posterPath,
              let encodedPath = posterPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        return URL(string: AppConstants.imageBaseURLString + encodedPath)
    }
    
    var releaseDate: String {
        "Release Date: \(movieDetail?.releaseDate ?? "")"
    }
    
    var runtime: String {
        "Runtime: \(movieDetail?.runtime ?? 0) min"
    }
    
    var rating: String {
        guard let movieDetail = movieDetail else { return "" }
        return "Rating: \(String(format: "%.2f", movieDetail.voteAverage)) (\(movieDetail.voteCount) votes)"
    }
}
