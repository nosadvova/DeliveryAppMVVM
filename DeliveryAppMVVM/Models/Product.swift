

import Foundation


struct Product {
    let name: String
    let price: Double
    var productImageURL: URL?
    var description: String?
    let id: String
    
    var isAdded = false
        
    init(id: String, dictionary: [String: AnyObject]) {
        self.name = dictionary["name"] as? String ?? ""
        self.price = dictionary["price"] as? Double ?? 0
        self.id = id
        
        if let description = dictionary["description"] as? String {
            self.description = description
        }
        
        if let productImageURL = dictionary["productImageURL"] as? String {
            guard let url = URL(string: productImageURL) else {return}
            self.productImageURL = url
        }
    }
}
