//
//  SideMenuView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 12/10/2021.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @Binding var currentDate: String
    @Binding var availableBusesAndTrams: [BusAndTram]
    
    var availableBuses: Int {
        return availableBusesAndTrams.unique(map: { $0.lineName }).filter({ $0.lineName.count > 2 }).count
    }
    
    var availableTrams: Int {
        return availableBusesAndTrams.unique(map: { $0.lineName }).filter({ $0.lineName.count <= 2 }).count
    }
    
    var body: some View {
        ZStack {
            Color(uiColor: .tertiarySystemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                SideMenuHeaderView(isShowing: $isShowing)
                
                VStack(alignment: .leading) {
                    Text("Dostępne linie:")
                        .font(.system(size: 15, weight: .bold))
                    
                    HStack(spacing: 12) {
                        Image("tram")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .clipped()
                            .frame(width: 45, height: 45)
                            .tint(Color(uiColor: .label))
                            .offset(x: -2.5)
                            .foregroundColor(Color(uiColor: UIColor(named: "tramCol")!))
                        Text("\(availableTrams)")
                            .offset(x: -5)
                            .font(.system(size: 15, weight: .bold))
                    }
                    .foregroundColor(Color(uiColor: .label))
                    
                    HStack(spacing: 12) {
                        Image("bus")
                            .renderingMode(.template)
                            .resizable()
                            .clipShape(Rectangle())
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color(uiColor: UIColor(named: "busCol")!))
                        Text("\(availableBuses)")
                            .font(.system(size: 15, weight: .bold))
                    }
                    .foregroundColor(Color(uiColor: .label))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                
                ForEach(SideMenuViewOption.allCases, id: \.self) { option in
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                    NavigationLink(
                        destination:
                            LazyBoxView(view: {
                                getDestination(forOption: option)
                                .navigationTitle("\(option.title)")
                                .navigationBarTitleDisplayMode(.inline)
                            }),
                            
                        label: {
                            SideMenuCell(option: option)
                        })
                }
                
                Text("Wersja 1.0")
                    .foregroundColor(Color.init(uiColor: .systemGray))
                    .font(.footnote)
                    .offset(x: 20, y: 0)
                
                Spacer()
            }
            .padding(.top, 44)
        }
        .ignoresSafeArea()
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true), currentDate: .constant("brak daty"), availableBusesAndTrams: .constant(allExampleAnnotations))
    }
}

extension SideMenuView {
    
    func getDestination(forOption option: SideMenuViewOption) -> AnyView {
        switch option {
        case .appinfo: return AnyView(SideMenuAppInfo(currentDate: $currentDate))
        case .privacypolicy: return AnyView(SideMenuPrivacyPolicy())
        }
    }
}
