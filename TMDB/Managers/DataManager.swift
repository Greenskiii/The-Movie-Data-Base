//
//  DataManager.swift
//  TMDB
//
//  Created by Алексей Даневич on 03.09.2021.
//

import Foundation
import RealmSwift
import os


struct DataManager {
    
    let realm = try? Realm()

    static let shared = DataManager()

    private init() { }
    
    func saveMovie(_ movie: Movie, completion: @escaping(() -> ())) {

        let movieRealm = MovieRealm()
        
        movieRealm.title = movie.title ?? ""
        movieRealm.date = movie.releaseDate ?? ""
        movieRealm.voteAverage = movie.voteAverage ?? 0.0
        movieRealm.overview = movie.overview ?? ""
        movieRealm.id = movie.id ?? 0
        movieRealm.backdropPath = movie.backdropPath ?? ""
        movieRealm.mediaType = movie.mediaType ?? ""
        movieRealm.posterPath = movie.posterPath ?? ""

        try? realm?.write {
            realm?.add(movieRealm)
        }
        completion()

    }
    
    func saveTvShow(_ movie: TvShow, completion: @escaping(() -> ())) {
        let movieRealm = MovieRealm()
        
        movieRealm.title = movie.originalName ?? ""
        movieRealm.date = movie.firstAirDate ?? ""
        movieRealm.voteAverage = movie.voteAverage ?? 0.0
        movieRealm.overview = movie.overview ?? ""
        movieRealm.id = movie.id ?? 0
        movieRealm.backdropPath = movie.backdropPath ?? ""
        movieRealm.mediaType = movie.mediaType ?? ""
        movieRealm.posterPath = movie.posterPath ?? ""
        
        try? realm?.write {
            realm?.add(movieRealm)
            
        }
        completion()
    }

    func getAllMovies(completion: ([MovieRealm])->()) {
        
        var moviesRealm = [MovieRealm]()
        guard let movieResults = realm?.objects(MovieRealm.self) else { return }
        for movie in movieResults {
            moviesRealm.append(movie)
        }
        
        completion(moviesRealm)
    }
    
    func deleteMoviesForFavoritesFromRealmByID(movieID: Int) {
        if let movieForFavoritesInRealm = realm?.objects(MovieRealm.self).filter("id = \(movieID)") {
            try? realm?.write {
                realm?.delete(movieForFavoritesInRealm)
            }
        }
    }
    
}
