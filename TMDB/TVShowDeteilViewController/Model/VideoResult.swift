import Foundation

struct VideoResult : Codable {
    
	let id: Int?
    let videos: [Video]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case videos = "results"
	}

}
