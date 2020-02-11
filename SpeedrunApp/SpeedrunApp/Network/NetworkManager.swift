//
//  NetworkManager.swift
//  SpeedrunApp
//
//  Created by nicholas.r.babo on 11/02/20.
//  Copyright © 2020 Nicholas.Babo. All rights reserved.
//

import Foundation

typealias APIResult = (Result<Data, Error>) -> Void

protocol NetworkManagerType {
    func request(for service: SRService, completion: @escaping APIResult)
}

final class NetworkManager: NetworkManagerType {
    private var baseURL: String = "https://www.speedrun.com/"

    private var successCodes: Range<Int> = 200..<299

    private var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60.0
        config.timeoutIntervalForResource = 80.0
        return URLSession(configuration: config)
    }()

    func request(for service: SRService, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = configureURL(with: service) else {
            return
        }

        execute(request: request, urlSession: session, completion: completion)
    }

    private func configureURL(with service: SRService) -> URLRequest? {
        let urlString = baseURL.appending(service.path)
        guard let url = URL(string: urlString) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = service.method.rawValue

//        let headers = [
////            "Content-Type" :"text/html; charset=UTF-8",
//            "Content-Type": "application/json",
////            "Content-Type": "application/x-www-form-urlencoded",
//            "Accept": "*/*"
////            "Accept": "application/json"
////            "Accept-Encoding": "gzip, deflate, br"
//        ]

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        request.addValue("Speedrun iOS App", forHTTPHeaderField: "User-Agent")

        request.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
        request.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        request.addValue("www.speedrun.com", forHTTPHeaderField: "Host")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")

        return request
    }

    private func execute(request: URLRequest,
                         urlSession: URLSession,
                         completion: APIResult?) {
        urlSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {

                guard let response = response as? HTTPURLResponse else {
                    return
                }

                guard self.successCodes.contains(response.statusCode) else {
                    let error = SRError(error: .unknown, statusCode: response.statusCode)
                    completion?(.failure(error))
                    return
                }

                guard let data = data else {
                    let error = SRError(error: .invalidData)
                    completion?(.failure(error))
                    return
                }

                completion?(.success(data))
            }
        }.resume()
    }
}
