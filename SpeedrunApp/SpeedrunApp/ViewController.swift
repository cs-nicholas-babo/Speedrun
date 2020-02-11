//
//  ViewController.swift
//  SpeedrunApp
//
//  Created by nicholas.r.babo on 11/02/20.
//  Copyright © 2020 Nicholas.Babo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let manager = NetworkManager()
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        manager.request(for: SRGamesService.allGames) { result in
            switch result {
            case .success(let data):
                do {
                    print(data.prettyPrintedJSONString)
                } catch {
                    print("error")
                }
            case .failure(let error):
                if let error = error as? SRError {
                    print(error.error)
                }
                print(error)
            }
        }
    }


}


extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
