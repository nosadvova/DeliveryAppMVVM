
import Foundation

class ProductManager {
    static let shared = ProductManager()
    private init() {}

    var products = [Product]()

    func toggleProductAdded(_ product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].isAdded.toggle()
        }
    }
}
