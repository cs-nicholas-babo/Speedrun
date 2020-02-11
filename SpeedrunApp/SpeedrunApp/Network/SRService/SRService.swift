//
//  SRService.swift
//  SpeedrunApp
//
//  Created by nicholas.r.babo on 11/02/20.
//  Copyright © 2020 Nicholas.Babo. All rights reserved.
//

import Foundation

protocol SRService {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Encodable? { get }
    var headers: [String: Any]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum SRGamesService {
    case allGames
}

struct SRResult<T: Decodable>: Decodable {
    var data: [T]
}
