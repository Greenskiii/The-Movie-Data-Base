
import UIKit
import SDWebImage
import os


class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.profileImageView.layer.cornerRadius = 16
    }
    
    
    func configure(actorName: String?, profilePath: String?) {

        self.profileNameLabel.text = actorName
        self.loadImage(profilePath: profilePath)
        self.setupCell()



    }
    
    private func loadImage(profilePath: String?) {

        guard let profilePath = profilePath else {
            os_log("RrofilePath is nil")
            return
        }
        let imageURL = URL(string: Constants.network.defaultImagePath + profilePath)
        self.profileImageView.sd_setImage(with: imageURL, completed: nil)
    }
    
    private func setupCell() {
        self.profileImageView.contentMode = .scaleAspectFill
    }

}
