
import Foundation
import os
import UIKit

class TvShowDetailViewModel {
    
    var tvShow: TvShow?
    
    func loadMovieVideoKey(_ movieId: String, completion: @escaping((String) -> ())) {
        
        NetworkManager.shared.loadMovieVideoKey(movieId, completion: { videoKey in
            completion(videoKey)
        })
    }
    
    func saveTvShowInRealm(_ tvShow: TvShow?, completion: @escaping(() -> ())) {
        
        guard let tvShow = tvShow else {
            os_log("There is no movie to save")
            return
        }
        
        DataManager.shared.saveTvShow(tvShow, completion: completion)
    }
    
    func setGradientBackground(view: UIView) {
        let colorTop =  UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0).cgColor
        let colorBottom = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at:0)
    }
}
