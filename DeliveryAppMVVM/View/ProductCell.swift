//
//  ProductCell.swift
//  DeliveryAppMVVM
//
//  Created by Vova Novosad on 15.03.2023.
//

import UIKit
import SDWebImage

class ProductCell: UITableViewCell {

//MARK: - Properties
    
    var product: Product? {
        didSet {
            configureCell()
        }
    }
    
    private let productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.setDimensions(width: 125, height: 60)
        
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .lightGray
        
        return label
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.setDimensions(width: 80, height: 30)
        button.layer.cornerRadius = 30 / 2
        
        button.setTitle("Add to cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        
        return button
    }()

    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(productImage)
        productImage.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor,
                            paddingTop: 5, paddingLeft: 10, paddingBottom: 5)
        
        let labelStack = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        contentView.addSubview(labelStack)
        labelStack.axis = .vertical
        labelStack.spacing = 25
        labelStack.anchor(top: topAnchor ,left: productImage.rightAnchor, paddingTop: 15, paddingLeft: 15)
        
        contentView.addSubview(addToCartButton)
        addToCartButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 25, paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func addToCartTapped() {
        
    }
    
    //MARK: - Functionality
    
    private func configureCell() {
        guard let product = product else { return }
        let viewModel = ProductViewModel(product: product)
        
        productImage.sd_setImage(with: viewModel.productImageURL, placeholderImage: UIImage(named: "placeholder"))
        nameLabel.text = viewModel.nameText
        priceLabel.text = viewModel.priceText
    }


}
