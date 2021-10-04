//
//  LineViewModel.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 07/09/2021.
//

import Foundation
import Combine
import MapKit

class LineViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    //@Published var favouriteLines = [VehicleAnnotation]()
    //@Published var lines = [VehicleAnnotation]()
    @Published var favouriteLinesName = [String]()
    
    //
    @Published var busesAndTrams = [BusAndTram]()
    // after specyfiying favouriteOnes from busesAndTrams
    @Published var favouriteBusesAndTram = [BusAndTram]()
    @Published var vehicleDictionary = [String: VehicleAnnotation]()
    
    //static let shared = LineViewModel(service: LineService())
    
    // MARK: - TO DO: hide api key
    let apiKey = "your api key"
    
    let service: LineService
    var subscriptions = Set<AnyCancellable>()
    
    init(service: LineService = LineService()) {
        self.service = service
        fetchLines()
    }
    
    func fetchLines() {
        print("Debug: - fetch lines call on timer publisher")
        isLoading = true
        errorMessage = nil
        
        let urlString = "https://api.um.warszawa.pl/api/action/busestrams_get/?resource_id=%20f2e5503e927d-4ad3-9500-4ab9e55deb59&apikey=\(apiKey)&type=1"
        let url = URL(string: urlString)
        
        service.fetchVehicles(url: url)
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] completion in
                self.isLoading = false
                
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(errorMessage as Any)
                case .finished:
                    print("Publisher stopped observing")
                }
            } receiveValue: { [unowned self] lines in
                self.busesAndTrams = lines
                specifyFavouriteLines()
            }.store(in: &subscriptions)
    }
    
    func specifyFavouriteLines() {
        $favouriteLinesName
            .removeDuplicates()
            .map({ [unowned self] selectedLinesNames in
                var favLines = [BusAndTram]()
                for line in selectedLinesNames {
                    for vehicle in self.busesAndTrams {
                        if vehicle.lineName == line {
                            favLines.append(vehicle)
                        }
                    }
                }
                return favLines
            })
            .assign(to: &$favouriteBusesAndTram)
        
        $favouriteBusesAndTram
            .removeDuplicates()
            .map({ favLines in
                var dict = [String: VehicleAnnotation]()
                for line in favLines {
                    dict[line.vehicleNumber] = VehicleAnnotation(lineName: line.lineName, vehicleNumber: line.vehicleNumber, brigade: "", latitude: line.latitude, longitude: line.longitude, coordinate: CLLocationCoordinate2D(latitude: line.latitude, longitude: line.longitude), title: line.lineName, subtitle: line.vehicleNumber)
                }
                return dict
            })
            .assign(to: &$vehicleDictionary)
    }
    
    // MARK: - MOCK DATA
    static func errorState() -> LineViewModel {
        let viewModel = LineViewModel()
        viewModel.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return viewModel
    }
    
    static func successState() -> LineViewModel {
        let viewModel = LineViewModel()
        //viewModel.lines = []//exampleAnnotation1, exampleAnnotation2]
        return viewModel
    }
}

////  Networking with completion without Combine Framework
//        service.fetchBusStructModels(url: url) { [unowned self] lines in
//            DispatchQueue.main.async {
//                self.isLoading = false
//
//                switch lines {
//                case .failure(let error):
//                    DispatchQueue.main.async {
//                        errorMessage = error.localizedDescription
//                        //print(error.description)
//                        print(error)
//                    }
//                case .success(let lines):
//                    self.busesAndTrams = lines
//                    specifyFavouriteLines()
//                }
//            }
//        }
