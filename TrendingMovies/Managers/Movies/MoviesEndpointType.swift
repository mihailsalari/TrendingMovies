import Foundation

enum MoviesEndpointType: String {
    case trending = "discover/movie"
    case details = "movie"
    
    func fullURLString(from baseURLString: String) -> String {
        baseURLString + rawValue
    }
}
