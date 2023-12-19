# TrendingMovies App

TrendingMovies is a simple iOS application that allows users to explore trending movies and view their details. While the app covers the basic functionality of displaying movie lists and details, it also serves as a demonstration of high-quality software development practices, including unit tests, modularization, and clean code principles.

## Features

- View a list of trending movies.
- Tap on a movie to view its details.
- View movie details such as title, release date, overview, rating, and poster.
- Asynchronous loading and display of movie posters.
- Accessibility features with VoiceOver support.
- Unit tests for the network and data layers.
- UI tests for the app's user interface.

## Technologies Used

- **SwiftUI**: Utilized for building the app's user interface.
- **Combine**: Employed for handling asynchronous operations and data binding.
- **URLSession**: Used for making network requests.
- **Codable**: Utilized for decoding JSON data from the network.
- **MVVM (Model-View-ViewModel) architectural pattern**: Adopted for structuring the app's components.

## Modularization

The codebase is structured with modularity in mind, making it easy to add new features or expand the app's functionality in the future. Key components, such as the ViewModel and network service, are separated for maintainability and scalability.

## API Key

To use the app, you'll need to obtain an API key from [The Movie Database (TMDb)](https://www.themoviedb.org/settings/api/request). Once you have your API key, replace the placeholder in the code with your actual key for accessing movie data.

