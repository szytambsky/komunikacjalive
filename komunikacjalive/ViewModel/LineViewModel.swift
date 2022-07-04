//
//  LineViewModel.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 07/09/2021.
//

import Foundation
import Combine
import MapKit
import SwiftUI


final class LineViewModel: ObservableObject {
    @Published private (set) var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published(key: "favouriteLinesName") var favouriteLinesName = [String]()
    @Published var currentDate: String = "Nie znaleziono daty"
    @Published var busesAndTrams = [BusAndTram]()
    @Published var favouriteBusesAndTram = [BusAndTram]()
    @Published private (set) var vehicleDictionary = [String: VehicleAnnotation]()
    
    // MARK: - TO DO: hide api key
    private let apiKey = "d6879599-0251-48ec-8255-8eca1412a91a"
    
    private let service: LineServiceProtocol
    var subscriptions = Set<AnyCancellable>()
    
    init(service: LineServiceProtocol = LineService()) {
        self.service = service
        fetchLines()
    }
    
    func fetchLines() {
        isLoading = true
        errorMessage = nil
        
        let urlTramsString = "https://api.um.warszawa.pl/api/action/busestrams_get/?resource_id=f2e5503e-927d-4ad3-9500-4ab9e55deb59&apikey=\(apiKey)&type=2"
        let urlBusesString = "https://api.um.warszawa.pl/api/action/busestrams_get/?resource_id=%20f2e5503e927d-4ad3-9500-4ab9e55deb59&apikey=\(apiKey)&type=1"
        let urlTrams = URL(string: urlTramsString)
        let urlBuses = URL(string: urlBusesString)
        
        service.fetchLines(urlBuses: urlBuses, urlTrams: urlTrams)
            .receive(on: DispatchQueue.main)
            .sink { [unowned self]  completion in
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
                
                if let time = lines.first?.time {
                    currentDate = time
                }
                
                specifyFavouriteLines()
            }.store(in: &subscriptions)
    }
    
    private func specifyFavouriteLines() {
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
            .sink { value in
                self.favouriteBusesAndTram = value
            }
            .store(in: &subscriptions)
        
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
}
