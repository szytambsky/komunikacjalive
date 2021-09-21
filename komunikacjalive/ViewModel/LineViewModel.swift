//
//  LineViewModel.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 07/09/2021.
//

import Foundation
import Combine

class LineViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var favouriteLines = [VehicleAnnotation]()
    @Published var lines = [VehicleAnnotation]()
    @Published var favouriteLinesName = [String]()
    
    //var subscriptions = Set<AnyCancellable>()
    
    // MARK: - TO DO: hide api key
    let apiKey = "your api key"
    
    let service: LineService
    
    init(service: LineService = LineService()) {
        self.service = service
        fetchLines()
        
        specifyFavouriteLines()
        //specifyFavouriteLinesBuses()
    }
    
    func fetchLines() {
        isLoading = true
        errorMessage = nil
        
        let urlString = "https://api.um.warszawa.pl/api/action/busestrams_get/?resource_id=%20f2e5503e927d-4ad3-9500-4ab9e55deb59&apikey=\(apiKey)&type=1"
        let url = URL(string: urlString)

        service.fetchBusAndTramLines(url: url) { [unowned self] lines in
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch lines {
                case .failure(let error):
                    DispatchQueue.main.async {
                        errorMessage = error.localizedDescription
                        //print(error.description)
                        print(error)
                    }
                case .success(let lines):
                    self.lines = lines
                }
            }
        }
    }
    
    func specifyFavouriteLines() {
        $favouriteLinesName
            .removeDuplicates()
            .map({ [unowned self] selectedLinesNames in
                var favLines = [VehicleAnnotation]()
                for line in selectedLinesNames {
                    for vehicle in self.lines {
                        if vehicle.lineName == line {
                            favLines.append(vehicle)
                        }
                    }
                }
                return favLines
            })
            .assign(to: &$favouriteLines)
        print(favouriteLines)
    }
    
//    func specifyFavouriteLinesBuses() {
//        $favouriteLinesName
//            .removeDuplicates()
//            .compactMap({ [unowned self] selectedLinesNames in
//                for line in selectedLinesNames {
//                    for vehicle in self.lines {
//                        if vehicle.lineName == line {
//                            self.favouriteLines.append(vehicle)
//                        }
//                    }
//                }
//                return self.favouriteLines
//            })
//            .sink { [unowned self] lines in
//                DispatchQueue.main.async {
//                    self.favouriteLines = lines
//                }
//            }
//            .store(in: &subscriptions)
//        print(favouriteLines)
//    }
//        $lines
//            .map({
//                for line in $0 {
//                    if self.favouriteLinesName.contains(line.lineName) {
//                        self.favouriteLines.append(line)
//                    }
//                }
//                print("DEBUG: \(self.favouriteLines)")
//                return self.favouriteLines
//            })
//            .assign(to: &$favouriteLines)
    
    // MARK: - MOCK DATA
    static func errorState() -> LineViewModel {
        let viewModel = LineViewModel()
        viewModel.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return viewModel
    }
    
    static func successState() -> LineViewModel {
        let viewModel = LineViewModel()
        viewModel.lines = []//exampleAnnotation1, exampleAnnotation2]
        return viewModel
    }
}
