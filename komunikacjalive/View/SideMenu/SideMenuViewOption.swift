//
//  SideMenuViewOption.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 12/10/2021.
//

import Foundation

enum SideMenuViewOption: Int, CaseIterable {
    case appinfo
    case privacypolicy
    
    var title: String {
        switch self {
        case .appinfo: return "O Aplikacji"
        case .privacypolicy: return "Polityka Prywatności"
        }
    }
    
    var imageName: String {
        switch self {
        case .appinfo: return "info.circle"
        case .privacypolicy: return "checkmark.shield"
        }
    }
}
