
import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.posterImageView.layer.cornerRadius = 16
    }
    
    func configure(imageURL: URL?, title: String?,  releaseDate: String?, voteAverage: Double?, overviewText: String?){
        self.titleLabel.text = title
        self.dateLabel.text = Constants.cell.realese + releaseDate!
        self.voteLabel.text = Constants.cell.rating + (String(describing: voteAverage))
        self.discriptionLabel.text = overviewText
        self.posterImageView.sd_setImage(with: imageURL, completed: nil)
        
    }
    
    private func setupCell() {
        self.posterImageView.contentMode = .scaleAspectFill
    }
    
    
    
}

