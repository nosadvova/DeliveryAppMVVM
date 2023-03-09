
import FirebaseDatabase
import FirebaseStorage

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PRODUCT_IMAGES = STORAGE_REF.child("product_images")

let DB_REF = Database.database().reference()
let DB_REF_PRODUCTS = DB_REF.child("products")

