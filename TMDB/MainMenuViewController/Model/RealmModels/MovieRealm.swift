
import Foundation

import RealmSwift

class MovieRealm: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var date = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var overview = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var backdropPath = ""
    @objc dynamic var mediaType = ""
    @objc dynamic var posterPath = ""

}
