//
//  SideMenuAppInfo.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 08/12/2021.
//

import SwiftUI

struct SideMenuAppInfo: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var currentDate: String
    
    var currentDateWithoutTime: String {
        let date = currentDate.components(separatedBy: " ")
        return date[0]
    }
    
    var body: some View {
        ZStack {
            List {
                ForEach(AppInfoContent.allCases, id: \.self) { item in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(item.title)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .font(.title2)
                        if item == .data {
                            Text("\(item.caption) \(currentDateWithoutTime).")
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .font(.body)
                                .padding()
                        } else {
                            Text(item.caption)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .font(.body)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
                .padding()
            }
            .listRowBackground(colorScheme == .dark ? Color.black : Color.white)
        }
        .ignoresSafeArea()
    }
}

struct SideMenuAppInfo_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuAppInfo(currentDate: .constant("data aktualna"))
    }
}

enum AppInfoContent: Int, CaseIterable, Equatable {
    case data
    
    var title: String {
        switch self {
        case .data: return "Dane"
        }
    }
    
    var caption: String {
        switch self {
        case .data: return "Lokalizacja GPS autobusów i tramwajów w Warszawie, źródlo danych pochodzi z Miasto Stołeczne Warszawa, i zostało pozyskane: "
        }
    }
}
