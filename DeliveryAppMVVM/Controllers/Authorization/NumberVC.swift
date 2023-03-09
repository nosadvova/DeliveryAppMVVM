
import UIKit
import Combine
import AEOTPTextField

class NumberVC: UIViewController {
    
    //MARK: - Properties
    
    private let logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = Utilities().textFieldSettings("Enter phone number")
        
        return textField
    }()
    
    private lazy var phoneContainerView: UIView = {
        let view = Utilities().inputContainerView(image: UIImage(named: "phone")!, textField: phoneTextField)
        
        return view
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = .systemBlue
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var codeTextField: AEOTPTextField = {
        let textField = AEOTPTextField()
        textField.textContentType = .oneTimeCode
        textField.configure(with: 6)
        textField.isHidden = true
        
        return textField
    }()
    
    private let phoneNumber = CurrentValueSubject<String, Error>(String())
    
    private var subscription = Set<AnyCancellable>()
    
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupInputSubscription()
    }
    
    //MARK: - Selectors
    
    @objc private func sendTapped() {
        guard let text = phoneTextField.text else {return}
        let phone = "+\(text)"
                
        AuthService.shared.authentication(number: phone) { [weak self] success in
            guard success else { return }
            self?.codeTextField.isHidden = false
        }
    }
    
    //MARK: - Functionality
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        codeTextField.otpDelegate = self
                
        view.addSubview(logoImage)
        logoImage.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImage.setDimensions(width: 100, height: 100)
        
        let stack = UIStackView(arrangedSubviews: [phoneContainerView, sendButton])
        view.addSubview(stack)
        stack.axis = .horizontal
        stack.spacing = 5
        stack.anchor(top: logoImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        
        view.addSubview(codeTextField)
        codeTextField.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 40)
        codeTextField.setDimensions(width: 300, height: 50)
    }
    
    private func setupInputSubscription() {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: phoneTextField)
            .compactMap({ ($0.object as? UITextField)?.text })
            .sink { [weak self] value in
                self?.phoneNumber.value = value
                
                if self?.phoneNumber.value.count == 12 {
                    self?.sendButton.isEnabled = true
                } else {
                    self?.sendButton.isEnabled = false
                }
            }
            .store(in: &subscription)
    }
}


//MARK: - AEOTPTextFieldDelegate

extension NumberVC: AEOTPTextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        phoneNumber.send(completion: .finished)
        AuthService.shared.smsCode(code: code) { [weak self] success in
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
            guard let tab = window.rootViewController as? MainTabBarVC else {return}
            
            tab.authenticateUser()
            self?.dismiss(animated: true)
        }
    }
}
