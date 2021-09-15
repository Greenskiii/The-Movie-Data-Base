
import Foundation
struct ActorsResult : Codable {
	let page : Int?
	let actors : [Actors]?
	let total_pages : Int?
	let total_results : Int?

	enum CodingKeys: String, CodingKey {

		case page = "page"
		case actors = "results"
		case total_pages = "total_pages"
		case total_results = "total_results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
        actors = try values.decodeIfPresent([Actors].self, forKey: .actors)
		total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
		total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
	}

}
