//
//  Coordinator.swift
//  SpeedrunApp
//
//  Created by nicholas.r.babo on 11/02/20.
//  Copyright © 2020 Nicholas.Babo. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var currentViewController: UIViewController { get }
    func start(with navigationType: NavigationType)
}

enum NavigationType {
    case present
    case push
    case root
}
