

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
    
    init(product: Product) {
        self.product = product
    }
}
