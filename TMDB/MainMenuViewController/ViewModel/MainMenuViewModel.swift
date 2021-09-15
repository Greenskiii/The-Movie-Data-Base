
import Foundation
import os

class MainMenuViewModel {
    var movies: [Movie] = []
    var actors: [Actors] = []
    var tvShow: [TvShow] = []
    var someMovies: [Movie]!
    
    func loadMovies(completion: @escaping(() -> ())){
        NetworkManager.shared.requestTopMovie(completion: {movies in
            self.movies = movies
            completion()
        })
    }
    
    func loadTvShow(completion: @escaping(() -> ())){
        NetworkManager.shared.requestTopTVShows(completion: {tvShow in
            self.tvShow = tvShow
            completion()
        })
    }
    
    func loadActors(completion: @escaping(() -> ())){
        NetworkManager.shared.requestActor(completion: {actors in
            self.actors = actors
            completion()
        })
    }
    func saveMovieInRealm(_ movie: Movie?, completion: @escaping(() -> ())) {
        
        guard let movie = movie else {
            os_log("There is no movie to save")
            return
        }
        
        DataManager.shared.saveMovie(movie, completion: completion)
    }
    
    func saveTvShowInRealm(_ movie: TvShow?, completion: @escaping(() -> ())) {
        
        guard let movie = movie else {
            os_log("There is no movie to save")
            return
        }
        
        DataManager.shared.saveTvShow(movie, completion: completion)
    }
}
