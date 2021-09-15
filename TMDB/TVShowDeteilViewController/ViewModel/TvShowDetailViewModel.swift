
import Foundation
import os

class TvShowDetailViewModel {
    
    var tvShow: TvShow?
    
    func loadMovieVideoKey(_ movieId: String, completion: @escaping((String) -> ())) {
        
        NetworkManager.shared.loadMovieVideoKey(movieId, completion: { videoKey in
            completion(videoKey)
        })
    }
    
    // Help
    func saveTvShowInRealm(_ tvShow: TvShow?, completion: @escaping(() -> ())) {
        
        guard let tvShow = tvShow else {
            os_log("There is no movie to save")
            return
        }
        
        DataManager.shared.saveTvShow(tvShow, completion: completion)
    }

}
