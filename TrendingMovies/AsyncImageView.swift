import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    let placeholderImage: Image

    init(url: URL?, placeholderImage: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholderImage = placeholderImage
    }

    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 220, alignment: .center)
        } placeholder: {
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: 400)
        .cornerRadius(10)
    }
}
