//
//  CategoryCell.swift
//  DeliveryAppMVVM
//
//  Created by Vova Novosad on 10.03.2023.
//

import UIKit
import SDWebImage

class CategoryCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var category: Category! {
        didSet {
            nameLabel.text = category.name
            categoryImage.sd_setImage(with: category.icon)
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 11)
        
        return label
    }()
    
    let categoryImage: UIImageView = {
        let image = UIImageView()
        image.setDimensions(width: 35, height: 35)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        return image
    }()
    
    override var isSelected: Bool {
        didSet {
            nameLabel.textColor = isSelected ? .red : .black
        }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stack = UIStackView(arrangedSubviews: [categoryImage, nameLabel])
        addSubview(stack)
        stack.center(inView: self)
        stack.axis = .vertical
        stack.spacing = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
