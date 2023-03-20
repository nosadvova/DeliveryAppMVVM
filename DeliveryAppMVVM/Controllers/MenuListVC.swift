//
//  MenuListVC.swift
//  DeliveryAppMVVM
//
//  Created by Vova Novosad on 27.02.2023.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol MenuListDelegate: AnyObject {
    func didSelectCategory(selectedCategory: String)
}

class MenuListVC: UICollectionViewController {
    
    
    //MARK: - Properties
    
    weak var delegate: MenuListDelegate?
    
    private var categories = [Category]() {
        didSet{
            collectionView.reloadData()
        }
    }
        
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
                
        fetchCategories()

        self.collectionView!.register(CategoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    //MARK: - API
    
    func fetchCategories() {
        ProductService.shared.fetchCategories { category in
            self.categories = category
        }
    }
}

// MARK: UICollectionViewDataSource

extension MenuListVC {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        
        cell.category = categories[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row].id
        self.delegate?.didSelectCategory(selectedCategory: category)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MenuListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let leftAndRightPaddings: CGFloat = 25
        let numberOfItemsPerRow: CGFloat = 3

        let parameters = (collectionView.frame.width - leftAndRightPaddings) / numberOfItemsPerRow
        return CGSize(width: parameters, height: parameters)
    }
}



