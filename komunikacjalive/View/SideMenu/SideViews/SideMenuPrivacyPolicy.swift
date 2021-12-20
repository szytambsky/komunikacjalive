//
//  PrivacyPolicy.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 02/12/2021.
//

import SwiftUI

struct SideMenuPrivacyPolicy: View {
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            List {
                ForEach(PrivacyPolicyContent.allCases, id: \.self) { item in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.caption)
                            .font(.caption)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .padding()
                
            }
            .foregroundColor(Color(uiColor: .label))
            .listRowBackground(Color(uiColor: .secondarySystemGroupedBackground))
        }
        //.ignoresSafeArea() if its remain the content will be cover by navigationbar (under the navigation bar)
    }
}

struct PrivacyPolicy_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuPrivacyPolicy()
    }
}

enum PrivacyPolicyContent: Int, CaseIterable, Equatable {
    case privacypolicy
    case installation
    case personalData
    case uninstall
    case complementary
    case reusetermsOfUse
    
    var title: String {
        switch self {
        case .privacypolicy: return "Polityka Prywatności aplikacji mobilnej Posbus - Po Stolicy Bus"
        case .installation: return ""
        case .personalData: return ""
        case .uninstall: return ""
        case .complementary: return ""
        case .reusetermsOfUse: return "Warunki ponownego wykorzystania"
        }
    }
    
    var caption: String {
        switch self {
        case .privacypolicy: return "1. Niniejszy dokument opisuje politykę prywatności aplikacji mobilnej Posbus (dalej \"aplikacja\"). Szymon Tamborski (dalej \"Organizator\"), traktuje ochronę prywatności w Internecie użytkowników aplikacji za pośrednictwem AppStore priorytetowo i dokłada wszelkich starań, aby ta prywatność była chroniona."
        case .installation: return "2. Aplikacja Posbus jest instalowana na urządzeniach mobilnych za pośrednictwem - w przypadku urządzenia mobilnego z systemem iOS, Apple AppStore. Korzystanie z aplikacji wymaga urządzenia mobilnego z internetem. Ta aplikacja może uzyskać dostęp do następujących uprawnień na urządzeniu mobilnym: lokalizacja GPS, aplikacja może wykorzystywać i udostępniać dane o lokalizacji urządzenia w celu świadczenia usług opartych na lokalizacji. Urządzenia mają domyślne narzędzia do zrezygnowania z tej funkcji."
        case .personalData: return "3. Korzystanie z aplikacji nie wymaga podania jakichkolwiek danych osobowych. Aplikacja nie przechowuje żadnych danych osobowych, które mogłyby umożliwić osobie trzeciej identyfikację konkretnego użytkownika aplikacji."
        case .uninstall: return "4. W przypadku braku zgody na niniejszą politykę prywatności proszę nie instalować aplikacji lub ją odinstalować. Trwałe usunięcie aplikacji z urządzenia mobilnego jest równoznaczne z zakończeniem korzystania z aplikacji."
        case .complementary: return "5. Niniejsza polityka prywatności ma jedynie charakter uzupełniający do polityki prywatności Apple Appstore. Organizator nie ponosi jakiejkolwiek odpowiedzialności za politykę prywatności Apple Appstore oraz przestrzeganie przepisów ustawy o ochronie danych osobowych oraz ustawy o świadczeniu usług drogą elektroniczną w ramach Apple Appstore."
        case .reusetermsOfUse: return "Aplikacja przestrzega warunki ponownego wykorzystywania informacji publicznej, wynikających z ustawy o ponownym wykorzystywaniu informacji sektora publicznego z 25 lutego 2016 r. Organizator aplikacji nie ponosi odpowiedzialności za ewentualną szkodę wynikającą z ponownego wykorzystania tych informacji przez użytkownika aplikacji. Zastrzega, że niektóre z ponownie wykorzystywanych informacji przetworzonych przez te aplikację mogą być nieaktualne lub zawierać błędy."
        }
    }
}
