

import FirebaseDatabase
import FirebaseAuth
import FirebaseCore

struct ProductCredentials {
    let name: String
    let price: Double
    let description: String?
    let image: UIImage
    let category: String
}

struct ProductService {
    static let shared = ProductService()
    
    func addProduct(product: ProductCredentials, completion: @escaping (Error?, DatabaseReference) -> ()) {
        let name = product.name
        let price = product.price
        let description = product.description
        let category = product.category
        
        guard let imageData = product.image.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PRODUCT_IMAGES.child(filename)
        
        storageRef.putData(imageData) { metadata, error in
            storageRef.downloadURL { url, error in
                guard let productImageUrl = url?.absoluteString else { return }
                
                let values = ["name": name,
                              "price": price,
                              "description": description ?? "",
                              "image": productImageUrl,
                              "category": category]
                
                DB_REF_PRODUCTS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
            }
        }
    }
    
    func fetchCategories(completion: @escaping ([Category]) -> ()) {
        var categories = [Category]()
        DB_REF_CATEGORIES.observe(.childAdded) { snapshot in
            let id = snapshot.key
            guard let values = snapshot.value as? [String: AnyObject] else { return }
            
            let category = Category(id: id, dictionary: values)
            categories.append(category)
            completion(categories)
        }
    }
    
    func fetchProducts(completion: @escaping ([Product]) -> ()) {
        var products = [Product]()
        
        DB_REF_PRODUCTS.observe(.childAdded) { snapshot in
            // Make sorting here using .orderByChild("category").equalTo(category.name)
            let id = snapshot.key
            guard let values = snapshot.value as? [String: AnyObject] else { return }

            let product = Product(id: id, dictionary: values)
            products.append(product)
            completion(products)
        }
    }
}
