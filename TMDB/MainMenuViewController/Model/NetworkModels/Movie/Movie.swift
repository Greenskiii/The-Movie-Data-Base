import Foundation
struct Movie : Codable {
    let releaseDate : String?
    let adult : Bool?
    let backdropPath : String?
    let genreIds : [Int]?
    let voteCount : Int?
    let originalLanguage : String?
    let originalTitle : String?
    let posterPath : String?
    let video : Bool?
    let id : Int?
    let voteAverage : Double?
    let title : String?
    let overview : String?
    let popularity : Double?
    let mediaType : String?

    enum CodingKeys: String, CodingKey {

        case releaseDate = "release_date"
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case voteCount = "vote_count"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case video = "video"
        case id = "id"
        case voteAverage = "vote_average"
        case title = "title"
        case overview = "overview"
        case popularity = "popularity"
        case mediaType = "media_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        genreIds = try values.decodeIfPresent([Int].self, forKey: .genreIds)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
    }

}
