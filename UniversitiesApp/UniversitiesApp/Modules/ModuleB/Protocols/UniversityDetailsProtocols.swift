//
//  UniversityDetailsProtocols.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 03/05/2024.
//

import UIKit
import NetworkManager

protocol UniversityDetailsView: AnyObject {
    func show()
}

protocol UniversityDetailsPresenter: AnyObject {
    func viewDidLoad(view: UniversityDetailsView)
    var universityName: String { get }
    var universityCountry: String { get }
    var universityState: String { get }
    var universityWebPage: String { get }
}

protocol UniversityDetailsInteractorInput: AnyObject {}

protocol UniversityDetailsInteractorOutput: AnyObject {}

protocol UniversityDetailsRouter: AnyObject {}

protocol UniversityDetailsRepo: AnyObject {}
