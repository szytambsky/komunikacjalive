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
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            List {
                ForEach(AppInfoContent.allCases, id: \.self) { item in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(item.title)
                            .font(.title2)
                        if item == .data {
                            Group {
                                Text("\(item.caption) \(currentDateWithoutTime).")
                                Text("\(item.timeDilatation)")
                            }
                            .font(.body)
                            .padding()
                        } else {
                            Text(item.caption)
                                .font(.body)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
                .padding()
            }
            .foregroundColor(Color(uiColor: .label))
            .listRowBackground(Color(uiColor: .secondarySystemGroupedBackground))
        }
        //.ignoresSafeArea() 
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
        case .data: return "Aplikacja przedstawia lokalizację GPS autobusów i tramwajów w Warszawie, źródło danych pochodzi z Miasto Stołeczne Warszawa, i zostało pozyskane: "
        }
    }
    
    var timeDilatation: String {
        return "Przedstawione w Aplikacji dane mają charakter poglądowy. Dane GPS podawane są najczęściej z około dwudziestosekundowym opóźnieniem."
    }
}
