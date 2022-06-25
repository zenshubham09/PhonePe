
import Foundation

struct MoviesModel : Codable {
	let dates : Dates?
	let page : Int?
	let results : [ResultsModel]?
	let total_pages : Int?
	let total_results : Int?

	enum CodingKeys: String, CodingKey {

		case dates
		case page
		case results = "results"
		case total_pages
		case total_results
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dates = try values.decodeIfPresent(Dates.self, forKey: .dates)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
		results = try values.decodeIfPresent([ResultsModel].self, forKey: .results)
		total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
		total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
	}
}
