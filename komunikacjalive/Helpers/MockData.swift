//
//  MockData.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 02/09/2021.
//

import Foundation
import SwiftUI

//latitude: 52.235031, longitude: 21.01876)

let exampleAnnotation1 = VehicleAnnotation(lineName: "7", vehicleNumber: "5555", brigade: "7", latitude: 52.235031, longitude: 21.01876)
let exampleAnnotation2 = VehicleAnnotation(lineName: "520", vehicleNumber: "4444", brigade: "4", latitude: 52.234031, longitude: 21.01976)

let allExampleAnnotations = [exampleAnnotation1, exampleAnnotation2]
let exampleLinesString = ["151", "520", "525", "168", "111", "131", "117"]

struct MockFunctions {
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

