//
//  Category.swift
//  DeliveryAppMVVM
//
//  Created by Vova Novosad on 10.03.2023.
//

import Foundation

struct Category {
    let id: String
    var name: String
    var icon: URL?
    
    var isSelected = false
    
    init(id: String, dictionary: [String: AnyObject]) {
        self.id = id
        self.name = dictionary["name"] as? String ?? ""
        
        if let icon = dictionary["icon"] as? String {
            guard let url = URL(string: icon) else { return }
            self.icon = url
        }
    }
}
