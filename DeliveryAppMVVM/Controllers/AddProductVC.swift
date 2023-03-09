

import UIKit

class AddProductVC: UIViewController {

    //MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var productImage: UIImage?
    
    
    private lazy var addPhoto: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addPhotoPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let email = Utilities().inputContainerView(textField: nameTextField)
        
        return email
    }()
    
    private lazy var passwordContainerView: UIView = {
        let password = Utilities().inputContainerView(textField: priceTextField)
        
        return password
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let fullName = Utilities().inputContainerView(textField: descriptionTextField)
        
        return fullName
    }()
    
    private lazy var usernameContainerView: UIView = {
        let username = Utilities().inputContainerView(textField: nameTextField)
        
        return username
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = Utilities().textFieldSettings("Name")
        
        return textField
    }()
    
    private lazy var priceTextField: UITextField = {
        let textField = Utilities().textFieldSettings("Price")
        
        return textField
    }()
    
    private lazy var descriptionTextField: UITextField = {
        let textField = Utilities().textFieldSettings("Description")
        
        return textField
    }()
    
    private lazy var addProduct: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(addProductPressed), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Selectors
    
    @objc func addPhotoPressed() {
        present(imagePicker, animated: true)
    }
    
    @objc private func addProductPressed() {
        guard let productImage = productImage else {return}
        guard let name = nameTextField.text else {return}
        guard let price = priceTextField.text else {return}
        guard let description = descriptionTextField.text else {return}
        
        let credentials = ProductCredentials(name: name, price: Double(price) ?? 0, description: description, image: productImage)

        ProductService.shared.addProduct(product: credentials) { error, reference in
            
        }

            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
            guard let tab = window.rootViewController as? MainTabBarVC else {return}

//            tab.authenticateUser()
            self.dismiss(animated: true)
        }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    //MARK: - Functionality
    
    func configureUI() {
        
        view.backgroundColor = .blue
                
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(addPhoto)
        addPhoto.anchor(width: 150, height: 150)
        addPhoto.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        
        let stackView = UIStackView(arrangedSubviews: [emailContainerView,
                                                       passwordContainerView,
                                                       fullnameContainerView,
                                                       usernameContainerView])
        view.addSubview(stackView)
        stackView.anchor(top: addPhoto.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10)
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(addProduct)
        addProduct.anchor(top: stackView.bottomAnchor, paddingTop: 30, width: 300, height: 50)
        addProduct.centerX(inView: view)
    }

}

//MARK: - UIImagePickerControllerDelegate

extension AddProductVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.editedImage] as? UIImage else {return}
        productImage = pickedImage
        
        addPhoto.setImage(pickedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        addPhoto.layer.cornerRadius = 150 / 2
        addPhoto.layer.masksToBounds = true
        dismiss(animated: true)
    }
}

