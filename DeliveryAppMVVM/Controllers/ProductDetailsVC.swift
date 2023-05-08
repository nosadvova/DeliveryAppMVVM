
import UIKit

class ProductDetailsVC: UIViewController {
    
    //MARK: - Properties
    
    var product: Product {
        didSet {
            configureData()
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
    
    private lazy var addToCartView = AddToCartView(product: product, width: 110, height: 40)
    

    //MARK: - Lifecycle
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Selectors
    
    @objc private func backTapped() {
        dismiss(animated: true)
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
        labelsStack.anchor(top: productImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 45, paddingLeft: 15, paddingRight: 20)
        labelsStack.axis = .vertical
        labelsStack.spacing = 50
        
        let priceStack = UIStackView(arrangedSubviews: [priceLabel, priceInfo])
        view.addSubview(priceStack)
        priceStack.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeft: 15, paddingBottom: 55)
        priceStack.axis = .vertical
        priceStack.spacing = 8
        
        configureData()
        
        view.addSubview(addToCartView)
        addToCartView.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 60, paddingRight: 35)
    }
    
    private func configureData() {
        let viewModel = ProductViewModel(product: product)
        
        productImage.sd_setImage(with: viewModel.productImageURL, placeholderImage: UIImage(named: "placeholder"))
        nameLabel.text = viewModel.nameText
        descriptionLabel.text = viewModel.description
        priceInfo.text = viewModel.priceText
    }
}
