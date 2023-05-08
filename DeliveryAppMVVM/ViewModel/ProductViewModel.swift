

import UIKit

struct ProductViewModel {
    let product: Product
    
    var productImageURL: URL? {
        return product.productImageURL
    }
    
    var nameText: String {
        return "\(product.name)"
    }
    
    var priceText: String {
        return String(product.price) + " uah"
    }
        
    var description: String? {
        return product.description
    }
    
    init(product: Product) {
        self.product = product
    }
}
