
import UIKit

class AddToCartView: UIView {
    
    //MARK: - Properties
            
    var product: Product {
        didSet {
            configureUI()
        }
    }
    
     var width: CGFloat
     var height: CGFloat
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.setDimensions(width: 80, height: 30)

        button.setTitle("Add to cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = .none

        button.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)

        return button
    }()
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setDimensions(width: 14, height: 14)
        button.addTarget(self, action: #selector(increaseTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setDimensions(width: 14, height: 14)
        button.addTarget(self, action: #selector(decreaseTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    private var countStack = UIStackView()

    
    //MARK: - Lifecycle
    
    init(product: Product, width: CGFloat, height: CGFloat) {
        self.product = product
        self.width = width
        self.height = height
        super.init(frame: .zero)
        
        countStack = UIStackView(arrangedSubviews: [decreaseButton, countLabel, increaseButton])
        addSubview(countStack)
        countStack.center(inView: self)
                        
        countStack.axis = .horizontal
        countStack.spacing = 15
        countStack.alignment = .center
        countStack.distribution = .equalCentering
                
        addSubview(addToCartButton)
        addToCartButton.center(inView: self)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Selectors
    
    @objc private func increaseTapped() {
        product.count += 1
    }
    
    @objc private func decreaseTapped() {
        if product.count > 1 {
            product.count -= 1
        } else {
            product.isAdded.toggle()
        }
    }
    
    @objc private func addToCartTapped() {
        product.isAdded.toggle()
    }
    
    private func configureUI() {
        
        let viewModel = AddToCartViewModel(product: product)
        backgroundColor = .black
        setDimensions(width: width, height: height)
        layer.cornerRadius = height / 2
        
        if viewModel.isAddedStatus == true {
            addToCartButton.isHidden = true
            countStack.isHidden = false
        } else {
            addToCartButton.isHidden = false
            countStack.isHidden = true
        }
    
        decreaseButton.setImage(viewModel.decreaseButtonImage, for: .normal)
        countLabel.text = "\(viewModel.count)"
    }
}
