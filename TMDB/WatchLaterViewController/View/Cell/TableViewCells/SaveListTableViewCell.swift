
import UIKit
import RealmSwift

class SaveListTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var discriptionLabel: UILabel!
    
    var movie: [MovieRealm] = []
    let realm = try? Realm()
    let baseImageURL = "https://image.tmdb.org/t/p/original/"

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.movie = self.getMovies()
        
    }

    
    
    private func getMovies() -> [MovieRealm] {
        
        var movies = [MovieRealm]()
        guard let citiesResults = realm?.objects(MovieRealm.self) else { return [] }
        for movie in citiesResults {
            movies.append(movie)
        }
        return movies
    }
    
    func configure(with result: MovieRealm){
        
        let pathURL = result.posterPath
        let fullURL = baseImageURL + pathURL
        self.posterImageView.sd_setImage(with: URL( string: fullURL, relativeTo: nil))
        
        
        
        self.titleLabel.text = result.title
        
        self.dateLabel.text = "Release date is \(result.date)"
        
        
        self.voteLabel.text = "Ratings is \(result.voteAverage)"
        
        
        
        self.discriptionLabel.text = result.overview
        
        
        
    }

    
}
