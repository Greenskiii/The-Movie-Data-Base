
import UIKit
import SDWebImage
import youtube_ios_player_helper
import Alamofire
import RealmSwift




class TVShowDeteilViewController: UIViewController {
    @IBOutlet weak var deteilLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var trailerVideoView: YTPlayerView!
    @IBOutlet weak var gradientView: UIView!
    var viewModel: TvShowDetailViewModel = TvShowDetailViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pathURL = self.viewModel.tvShow?.backdropPath {
            let fullURL = Constants.network.defaultImagePath + pathURL
            self.imageView.sd_setImage(with: URL( string: fullURL, relativeTo: nil))
        }
        self.deteilLabel.text = self.viewModel.tvShow?.overview
        self.title = self.viewModel.tvShow?.originalName
        if let id = self.viewModel.tvShow?.id {
            let stringID = String(describing: id)
            self.requestVideos(with: stringID)
        }
        
        self.setGradientBackground(view: gradientView)
        
        
        let logoutBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addToWatchLaterButtonPressed))
        self.navigationItem.rightBarButtonItem = logoutBarButtonItem
        
        
        
    }
    
    func requestVideos(with movieId: String) {
        
        self.viewModel.loadMovieVideoKey(movieId) { videoKey in
            self.trailerVideoView.load(withVideoId: videoKey)
        }
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
    
    
    
    
    private func loadByKey(_ key: String) {
        self.trailerVideoView.load(withVideoId: key)
    }
    
    
    
    
    @objc func addToWatchLaterButtonPressed() {
        
        self.viewModel.saveTvShowInRealm(self.viewModel.tvShow, completion: {
            
            let alert = UIAlertController(title: Constants.alert.success,
                                          message: nil,
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: Constants.alert.ok,
                                          style: UIAlertAction.Style.default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
}



