
import UIKit

struct AddToCartViewModel {
    
    let product: Product
    
    var decreaseButtonImage: UIImage {
        return product.count > 1 ? UIImage(named: "minus")! : UIImage(named: "trash")!
    }
    
    var isAddedStatus: Bool {
        return product.isAdded ? true : false
    }
        
    var count: Int {
        return product.count
    }
    
    init(product: Product) {
        self.product = product
    }
}
