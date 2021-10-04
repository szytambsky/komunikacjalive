//
//  LineService.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 11/09/2021.
//

import Foundation
import Combine

struct LineService {
    
    func fetchVehicles(url: URL?) -> AnyPublisher<[BusAndTram], Error> {
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map { $0.data }
            .decode(type: BusAndTramResult.self, decoder: JSONDecoder())
            .map { $0.result }
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

///// print json data
//     if let data = data, let jsonData = String(data: data, encoding: .utf8) {
//         print(jsonData)
//     }

//// Generic fetch function without Combine Framework
//func fetch<T: Codable>(_ type: T.Type, url: URL?, completion: @escaping (Result<T, APIError>) -> Void) {
//    guard let url = url else {
//        let error = APIError.badURL
//        completion(Result.failure(error))
//        return
//    }
//
//    let task = URLSession.shared.dataTask(with: url) { data, response, error in
//        if let error = error as? URLError {
//            completion(Result.failure(.url(error)))
//        } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
//            let err = APIError.badResponse(statusCode: response.statusCode)
//            completion(Result.failure(err))
//        } else if let data = data {
//            let decoder = JSONDecoder()
//
//            do {
//                let result = try decoder.decode(type, from: data)
//                print("result: \(result)")
//                completion(Result.success(result))
//            } catch {
//                completion(Result.failure(APIError.parsing(error as? DecodingError)))
//            }
//        }
//    }
//
//    task.resume()
//}

