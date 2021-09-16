
import UIKit
import youtube_ios_player_helper


class MovieDeteilViewController: UIViewController {
    @IBOutlet weak var deteilLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var trailerVideoView: YTPlayerView!
    @IBOutlet weak var gradientView: UIView!
    var viewModel: MediaDetailViewModel = MediaDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pathURL = self.viewModel.movie?.backdropPath {
            let fullURL = Constants.network.defaultImagePath + pathURL
            self.imageView.sd_setImage(with: URL( string: fullURL, relativeTo: nil))
        }
        
        if let id = self.viewModel.movie?.id {
            let stringID = String(describing: id)
            self.requestVideos(with: stringID)
        }
        self.title = self.viewModel.movie?.originalTitle
        self.deteilLabel.text = self.viewModel.movie?.overview
        
        
        self.viewModel.setGradientBackground(view: gradientView)
        
        let logoutBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addToWatchLaterButtonpressed))
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
    

    
    @objc func addToWatchLaterButtonpressed(){

        self.viewModel.saveMovieInRealm(self.viewModel.movie, completion: {

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

