//
//  SRError.swift
//  SpeedrunApp
//
//  Created by nicholas.r.babo on 11/02/20.
//  Copyright © 2020 Nicholas.Babo. All rights reserved.
//

import Foundation

struct SRError: Error {
    var error: SRAPIError
    var statusCode: Int?
    var data: Data?
}

public enum SRAPIError {
    case invalidURL
    case invalidData
    case unknown
}
