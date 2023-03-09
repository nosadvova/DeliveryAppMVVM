

import FirebaseDatabase
import FirebaseAuth
import FirebaseCore

struct ProductCredentials {
    let name: String
    let price: Double
    let description: String?
    let image: UIImage
}

struct ProductService {
    static let shared = ProductService()
    
    func addProduct(product: ProductCredentials, completion: @escaping (Error?, DatabaseReference) -> ()) {
        let name = product.name
        let price = product.price
        let description = product.description
        
        guard let imageData = product.image.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PRODUCT_IMAGES.child(filename)
        
        storageRef.putData(imageData) { metadata, error in
            storageRef.downloadURL { url, error in
                guard let productImageUrl = url?.absoluteString else { return }
                
                let values = ["name": name,
                              "price": price,
                              "description": description ?? "",
                              "image": productImageUrl]
                
                DB_REF_PRODUCTS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
            }
        }
    }
}
