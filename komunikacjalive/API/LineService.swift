//
//  LineService.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 11/09/2021.
//

import Foundation
import Combine

struct LineService {
    
    func fetchBuses(url: URL?) -> AnyPublisher<[BusAndTram], Error> {
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map { $0.data }
            .decode(type: BusAndTramResult.self, decoder: JSONDecoder())
            .map { $0.result }
            .eraseToAnyPublisher()
    }
    
    func fetchTrams(url: URL?) -> AnyPublisher<[BusAndTram], Error> {
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map { $0.data }
            .decode(type: BusAndTramResult.self, decoder: JSONDecoder())
            .map { $0.result }
            .eraseToAnyPublisher()
    }
    
    func fetchLines(urlBuses: URL?, urlTrams: URL?) -> AnyPublisher<[BusAndTram], Error> {
        return Publishers.Zip(fetchBuses(url: urlBuses), fetchTrams(url: urlTrams))
            .map { lines -> [BusAndTram] in
                let lines = lines.0 + lines.1
                return lines//.sorted {$0.lineName.localizedStandardCompare($1.lineName) == .orderedAscending}
                //return (lines.0 + lines.1).sorted { $0.lineName < $1.lineName }
            }
            .eraseToAnyPublisher()
    }
    
    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func fetchBusStructModels(url: URL?) -> AnyPublisher<[BusAndTram], Error> {
        Future { promise in // <- return Future & ^ Future instead of AnyPublisher
            guard let url = url else {
                let error = APIError.badURL
                promise(.failure(error))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error as? URLError {
                    promise(.failure(APIError.url(error)))
                } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    let err = APIError.badResponse(statusCode: response.statusCode)
                    promise(Result.failure(err))
                } else if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let json = try decoder.decode(BusAndTramResult.self, from: data)
                        let lines = json.result
                        DispatchQueue.main.async {
                            print("fetched in line service")
                            promise(.success(lines))
                        }
                        
                    } catch {
                        promise(.failure(APIError.parsing(error as? DecodingError)))
                    }
                }
            }
            
            task.resume()
        }
        .eraseToAnyPublisher()
    }
}
