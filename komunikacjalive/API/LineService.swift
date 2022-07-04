//
//  LineService.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 11/09/2021.
//

import Foundation
import Combine

internal protocol LineServiceProtocol {
    func fetchLines(urlBuses: URL?, urlTrams: URL?) -> AnyPublisher<[BusAndTram], Error>
}

struct LineService {
    
    private func fetchBuses(url: URL?) -> AnyPublisher<[BusAndTram], Error> {
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map { $0.data }
            .decode(type: BusAndTramResult.self, decoder: JSONDecoder())
            .map { $0.result }
            .eraseToAnyPublisher()
    }
    
    private func fetchTrams(url: URL?) -> AnyPublisher<[BusAndTram], Error> {
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map { $0.data }
            .decode(type: BusAndTramResult.self, decoder: JSONDecoder())
            .map { $0.result }
            .eraseToAnyPublisher()
    }
    
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

// MARK: - LineServiceProtocol

extension LineService: LineServiceProtocol {
    func fetchLines(urlBuses: URL?, urlTrams: URL?) -> AnyPublisher<[BusAndTram], Error> {
        return Publishers.Zip(fetchBuses(url: urlBuses), fetchTrams(url: urlTrams))
            .map { lines -> [BusAndTram] in
                let lines = lines.0 + lines.1
                return lines//.sorted {$0.lineName.localizedStandardCompare($1.lineName) == .orderedAscending}
                //return (lines.0 + lines.1).sorted { $0.lineName < $1.lineName }
            }
            .eraseToAnyPublisher()
    }
}
