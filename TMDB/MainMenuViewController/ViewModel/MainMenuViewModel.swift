
import Foundation

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
}
