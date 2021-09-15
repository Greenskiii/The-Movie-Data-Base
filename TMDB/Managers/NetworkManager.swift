//
//  NetworkManager.swift
//  TMDB
//
//  Created by Алексей Даневич on 03.09.2021.
//

import Foundation
import Alamofire


struct NetworkManager{
    
    static let shared = NetworkManager()

    private init() { }
    
    func requestTopMovie(completion: @escaping(([Movie]) -> ())) {
        let url = Constants.network.popularMoviePath + Constants.network.apiKey
        
        AF.request(url).responseJSON { responseJSON in
            let decoder = JSONDecoder()
            
            if let data = try? decoder.decode(TopMovie.self, from: responseJSON.data!){
                
                let topMovie = data.movie ?? []
                completion(topMovie)
            }
        }
    }
    
    func requestTopTVShows(completion: @escaping(([TvShow]) -> ())) {
        let url = Constants.network.popularTvShowPath + Constants.network.apiKey
        
        AF.request(url).responseJSON { responseJSON in
            let decoder = JSONDecoder()
            
            if let data = try? decoder.decode(TopTVShow.self, from: responseJSON.data!){
                
                let topTvShow = data.tvShow ?? []
                completion(topTvShow)
            }
        }
    }

    func requestActor(completion: @escaping(([Actors]) -> ())) {
        
        let url = Constants.network.popularActorPath + Constants.network.apiKey
        
        AF.request(url).responseJSON { responce in
            let decoder = JSONDecoder()
            
            if let data = try? decoder.decode(ActorsResult.self, from: responce.data!) {
                
                let actors = data.actors ?? []
                completion(actors)
            }
        }
    }
    
    func loadMovieVideoKey(_ movieId: String, completion: @escaping((String) -> ())) {
        
        let url = Constants.network.defaultPath + "movie/\(movieId)/videos?api_key=" + Constants.network.apiKey
        
        AF.request(url).responseJSON { response in

            let decoder = JSONDecoder()

            if let data = try? decoder.decode(MovieVideosResult.self, from: response.data!) {
                let videoKey =  data.videos?.first?.key ?? ""
                completion(videoKey)
            }
        }
    }
}
