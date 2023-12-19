import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    let viewModel: any MoviesViewModelProtocol
    
    var body: some View {
        HStack(alignment: .center, spacing: 12)  {
            AsyncImageView(url: viewModel.getFullPosterURL(with: movie))
                .frame(width: 80, height: 120)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                Text(viewModel.releaseDate(movie: movie))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(viewModel.rating(movie: movie))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(movie.overview)
                    .font(.caption)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityIdentifier("\(AccessibilityIdentifiers.movieRow)")
    }
}
