//
//  Constants.swift
//  TMDB
//
//  Created by Алексей Даневич on 03.09.2021.
//

import Foundation


struct Constants {
    
    struct network {
        
        static let apiKey = "2f3514b35d08cf28ef6720d772deb190"
        static let popularMoviePath = "https://api.themoviedb.org/3/trending/movie/week?api_key="
        static let popularTvShowPath = "https://api.themoviedb.org/3/trending/tv/week?api_key="
        static let popularActorPath = "https://api.themoviedb.org/3/person/popular?api_key="
        static let defaultImagePath = "https://image.tmdb.org/t/p/original/"
        static let defaultPath = "https://api.themoviedb.org/3/"
    }
    struct cell {
        static let realese = "Release date is "
        static let rating = "Ratings is "

    }
    struct alert {
        static let success = "Saving successfully"
        static let ok = "Ok"

    }
    
    
    
    
}
