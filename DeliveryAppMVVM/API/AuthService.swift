

import Foundation
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    private var verifyID: String?
    
     func authentication(number: String, completion: @escaping (Bool) -> ()) {
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { [weak self] verifyID, error in
            guard let verifyID = verifyID else {
                completion(false)
                return
            }
            self?.verifyID = verifyID
            completion(true)
        }
    }
    
    func smsCode(code: String, completion: @escaping (Bool) -> ()) {
        guard let verifyID = verifyID else {
            completion(false)
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID, verificationCode: code)
        
        
        Auth.auth().signIn(with: credential) { result, error in
            completion(true)
        }
    }
}
