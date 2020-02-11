//
//  SRGamesService.swift
//  SpeedrunApp
//
//  Created by nicholas.r.babo on 11/02/20.
//  Copyright © 2020 Nicholas.Babo. All rights reserved.
//

import Foundation

extension SRGamesService: SRService {
    var path: String {
        switch self {
        case .allGames: return "games"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .allGames: return .get
        }
    }

    var parameters: Encodable? {
        switch self {
        case .allGames: return nil
        }
    }

    var headers: [String : Any]? {
        switch self {
        case .allGames: return nil
        }
    }
}
