
import UIKit
import SideMenu

private let reuseIdentifier = "Cell"

class MarketVC: UITableViewController, UINavigationControllerDelegate {
    
    //MARK: - Properties
    
    var products = [Product]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedCategory: Category? {
        didSet {
//            fetchProducts(categoryID: selectedCategory?.id ?? "fruit")
//            tableView.reloadData()
        }
    }

    lazy var hamburgerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menuIcon"), for: .normal)
        button.addTarget(self, action: #selector(hamburgerTapped), for: .touchUpInside)

        return button
    }()
    
    lazy var addProduct: UIButton = {
       let button = UIButton()
       button.setImage(UIImage(systemName: "plus"), for: .normal)
       button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
       
       return button
   }()
    
    private let menu = SideMenuNavigationController(rootViewController: MenuListVC(collectionViewLayout: UICollectionViewFlowLayout()))
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ProductCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
                
        configureUI()
        fetchProducts(categoryID: selectedCategory?.id ?? "fruit")
    }
    
    //MARK: - API
    
    private func fetchProducts(categoryID: String) {
        ProductService.shared.fetchProducts { products in
            let sorted = products.filter({ $0.category == categoryID })
            self.products = sorted
        }
    }
    
    //MARK: - Selectors
    
    @objc private func hamburgerTapped() {
        present(menu, animated: true)
    }
    
    @objc private func addTapped() {
        present(AddProductVC(), animated: true)
    }
    
    //MARK: - Functionality
        
    private func configureUI() {
        configureNavigationItem()
    }
    
    private func configureNavigationItem() {
        menu.delegate = self
        menu.leftSide = true
        menu.navigationBar.isHidden = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addProduct)
    }
}


// MARK: - Table view data source

extension MarketVC {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProductCell
        
        cell.product = products[indexPath.row]
        
        return cell
    }
}

//MARK: - MenuListDelegate

extension MarketVC: MenuListDelegate {
    func selectedCategory(category: Category) {
        self.selectedCategory = category
    }
}
