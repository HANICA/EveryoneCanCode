import Foundation

struct MenuItem: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    //var imageName : String
    var imageURL: String // should be type URL, but does not seem to work then
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case category
        //case imageName = ""
        case imageURL
            //= "image_url"
    }
}

struct MenuItems: Codable {
    let items: [MenuItem]
}
