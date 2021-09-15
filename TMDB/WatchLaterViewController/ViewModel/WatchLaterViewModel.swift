
import Foundation
import os
import RealmSwift

class WatchLaterViewModel {

    var movies: [MovieRealm] = []
    var filteredMovie: [MovieRealm] = []
    var movie: [MovieRealm] = []

    func getAllMovies(completion: @escaping(() -> ())) {
        DataManager.shared.getAllMovies(completion: { movies in
            self.movies = movies
        })
    }
}
