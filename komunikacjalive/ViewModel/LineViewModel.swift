//
//  LineViewModel.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 07/09/2021.
//

import Foundation

class LineViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var favouriteLines = [VehicleAnnotation]()
    @Published var lines = [VehicleAnnotation]()
    
    // MARK: - TO DO: hide api key
    let apiKey = "your key"
    
    let service: LineService
    
    init(service: LineService = LineService()) {
        self.service = service
        fetchLines()
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
    
    
    
    // MARK: - MOCK DATA
    static func errorState() -> LineViewModel {
        let viewModel = LineViewModel()
        viewModel.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return viewModel
    }
    
    static func successState() -> LineViewModel {
        let viewModel = LineViewModel()
        viewModel.lines = [exampleAnnotation1, exampleAnnotation2]
        return viewModel
    }
}
