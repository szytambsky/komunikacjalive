//
//  LineService.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 11/09/2021.
//

import Foundation
import Combine

struct LineService {
    
    func fetch<T: Codable>(_ type: T.Type, url: URL?, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                let err = APIError.badResponse(statusCode: response.statusCode)
                completion(Result.failure(err))
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode(type, from: data)
                    print("result: \(result)")
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        
        task.resume()
    }
    
//    func fetchBusAndTramLines(url: URL?, completion: @escaping (Result<[VehicleAnnotation], APIError>) -> Void) {
//        guard let url = url else {
//            let error = APIError.badURL
//            completion(Result.failure(error))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error as? URLError {
//                completion(Result.failure(.url(error)))
//            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
//                let err = APIError.badResponse(statusCode: response.statusCode)
//                completion(Result.failure(err))
//            } else if let data = data {
//                let decoder = JSONDecoder()
//
//                do {
//                    let json = try decoder.decode(VehiclesLocationResult.self, from: data)
//                    let lines = json.result
//                    DispatchQueue.main.async {
//                        completion(Result.success(lines))
//                    }
//
//                } catch {
//                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
//                }
//            }
//        }
//
//        task.resume()
//    }
    
    func fetchBusStructModels(url: URL?, completion: @escaping (Result<[BusAndTram], APIError>) -> Void) {
        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                let err = APIError.badResponse(statusCode: response.statusCode)
                completion(Result.failure(err))
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let json = try decoder.decode(BusAndTramResult.self, from: data)
                    let lines = json.result
                    DispatchQueue.main.async {
                        print("fetched in line service")
                        completion(Result.success(lines))
                    }
                    
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        
        task.resume()
    }
//    func fetchBusStructModels(url: URL?, completion: @escaping (Result<[BusAndTram], APIError>) -> Void) {
//        guard let url = url else {
//            let error = APIError.badURL
//            completion(Result.failure(error))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error as? URLError {
//                completion(Result.failure(.url(error)))
//            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
//                let err = APIError.badResponse(statusCode: response.statusCode)
//                completion(Result.failure(err))
//            } else if let data = data {
//                let decoder = JSONDecoder()
//
//                do {
//                    let json = try decoder.decode(BusAndTramResult.self, from: data)
//                    let lines = json.result
//                    DispatchQueue.main.async {
//                        print("fetched in line service")
//                        completion(Result.success(lines))
//                    }
//
//                } catch {
//                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
//                }
//            }
//        }
//
//        task.resume()
//    }
}


//            if let data = data, let jsonData = String(data: data, encoding: .utf8) {
//                print(jsonData)
//            }
