
import UIKit
import youtube_ios_player_helper


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
        
        self.viewModel.setGradientBackground(view: gradientView)
        
        let logoutBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addToWatchLaterButtonPressed))
        self.navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    func requestVideos(with movieId: String) {
        
        self.viewModel.loadMovieVideoKey(movieId) { videoKey in
            self.trailerVideoView.load(withVideoId: videoKey)
        }
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
