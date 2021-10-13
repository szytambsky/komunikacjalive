//
//  SideMenuViewOption.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 12/10/2021.
//

import Foundation

enum SideMenuViewOption: Int, CaseIterable {
    case moreinfo
    case author
    
    var title: String {
        switch self {
        case .moreinfo: return "Polityka Prywatności"
        case .author: return "O Autorze"
        }
    }
    
    var imageName: String {
        switch self {
        case .moreinfo: return "info.circle"
        case .author: return "person.circle"
        }
    }
}
