
import UIKit
import SideMenu

class MarketVC: UITableViewController, UINavigationControllerDelegate {
    
    //MARK: - Properties
    
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
                
        configureUI()
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
