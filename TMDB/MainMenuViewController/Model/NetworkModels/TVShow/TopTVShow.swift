import Foundation
struct TopTVShow : Codable {
	let page : Int?
	let tvShow : [TvShow]?
	let total_pages : Int?
	let total_results : Int?

	enum CodingKeys: String, CodingKey {

		case page = "page"
		case tvShow = "results"
		case total_pages = "total_pages"
		case total_results = "total_results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
        tvShow = try values.decodeIfPresent([TvShow].self, forKey: .tvShow)
		total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
		total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
	}

}
