import SwiftUI

@main
struct TrendingMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MoviesView(viewModel: MoviesViewModel(movieService: MovieService(networkService: APIService(),
                                                                             baseURLString: AppConstants.moviesBaseURLString,
                                                                             apiKey: AppConstants.moviesAPIKey)))
        }
    }
}
