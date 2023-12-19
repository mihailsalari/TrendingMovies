import SwiftUI
import Combine

struct MoviesView: View {
    @ObservedObject var viewModel: MoviesViewModel

    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
         NavigationView {
             List(viewModel.movies, id: \.id) { movie in
                 NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movieService: MovieService(networkService: APIService(),
                                                                                                                        baseURLString: AppConstants.moviesBaseURLString,
                                                                                                                        apiKey: AppConstants.moviesAPIKey), movieId: movie.id))) {
                     MovieRowView(movie: movie, viewModel: viewModel)
                 }
             }
             .accessibilityIdentifier(AccessibilityIdentifiers.movieList)
             .navigationBarTitle("Trending Movies")
         }
         .onAppear {
             viewModel.loadMovies()
         }
     }
}
