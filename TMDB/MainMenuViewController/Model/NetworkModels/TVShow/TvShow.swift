import Foundation
struct TvShow : Codable {
	let genreIds : [Int]?
	let originalLanguage : String?
	let posterPath : String?
	let voteCount : Int?
	let voteAverage : Double?
	let backdropPath : String?
	let overview : String?
	let id : Int?
	let originalName : String?
	let originCountry : [String]?
	let firstAirDate : String?
	let name : String?
	let popularity : Double?
	let mediaType : String?

	enum CodingKeys: String, CodingKey {

		case genreIds = "genre_ids"
		case originalLanguage = "original_language"
		case posterPath = "poster_path"
		case voteCount = "vote_count"
		case voteAverage = "vote_average"
		case backdropPath = "backdrop_path"
		case overview = "overview"
		case id = "id"
		case originalName = "original_name"
		case originCountry = "origin_country"
		case firstAirDate = "first_air_date"
		case name = "name"
		case popularity = "popularity"
		case mediaType = "media_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        genreIds = try values.decodeIfPresent([Int].self, forKey: .genreIds)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
        originCountry = try values.decodeIfPresent([String].self, forKey: .originCountry)
        firstAirDate = try values.decodeIfPresent(String.self, forKey: .firstAirDate)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
	}

}
