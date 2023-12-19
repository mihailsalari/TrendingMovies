import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel

    var body: some View {
        ScrollView {
            if let movieDetail = viewModel.movieDetail {
                VStack(alignment: .center) {
                    AsyncImageView(url: viewModel.getFullPosterURL(with: movieDetail.posterPath))
                }

                VStack(alignment: .leading) {
                    Text(movieDetail.title)
                        .font(.largeTitle)
                    Text(viewModel.releaseDate)
                    Text(viewModel.runtime)
                    Text(viewModel.rating)
                    Text(movieDetail.overview)
                        .padding(.top)

                    HStack {
                        ForEach(movieDetail.genres, id: \.id) { genre in
                            Text(genre.name)
                                .padding(5)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        }
                    }
                }
                .padding()
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            viewModel.loadMovieDetails()
        }
        .navigationBarTitle("", displayMode: .inline)
        .accessibilityIdentifier(AccessibilityIdentifiers.movieDetailView)
    }
}
