
import UIKit

class ProductDetailsVC: UIViewController {
    
    //MARK: - Properties
    
    var product: Product {
        didSet {
            configureUI()
        }
    }
    
    private let productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
                
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
                
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
                
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        
        return label
    }()
    
    private let priceInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.setDimensions(width: 90, height: 40)
        button.layer.cornerRadius = 40 / 2
        
        button.setTitle("Add to cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        
        return button
    }()
    //MARK: - Lifecycle
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc private func backTapped() {
        dismiss(animated: true)
    }
    
    @objc private func addToCartTapped() {
        print("Tapped")
    }
    
    //MARK: - Functionality
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = backButton
        
        view.addSubview(productImage)
        productImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, height: 250)
        
        let labelsStack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        view.addSubview(labelsStack)
        labelsStack.anchor(top: productImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 45, paddingLeft: 15)
        labelsStack.axis = .vertical
        labelsStack.spacing = 50
        
        let priceStack = UIStackView(arrangedSubviews: [priceLabel, priceInfo])
        view.addSubview(priceStack)
        priceStack.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeft: 15, paddingBottom: 34)
        priceStack.axis = .vertical
        priceStack.spacing = 8
        
        view.addSubview(addToCartButton)
        addToCartButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 45, paddingRight: 35)
        
        
        productImage.sd_setImage(with: product.productImageURL)
        nameLabel.text = product.name
        descriptionLabel.text = product.description
        priceInfo.text = "\(product.price) uah"
    }
}
