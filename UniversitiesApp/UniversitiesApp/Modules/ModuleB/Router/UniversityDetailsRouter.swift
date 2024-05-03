//
//  UniversityDetailsRouter.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 03/05/2024.
//

import Foundation
import UIKit

final class UniversityDetailsRouterImplementation: UniversityDetailsRouter {
    weak var viewController: UniversityDetailsViewController?
    
    func build(university: University) -> UIViewController {
        let router = UniversityDetailsRouterImplementation()
        let repo = UniversityDetailsRepoImplementation()
        let interactor = UniversityDetailsInteractor(repo: repo)
        let presenter = UniversityDetailsPresenterImplementation(university: university, router: router, interactor: interactor)
        let view = UniversityDetailsViewController(presenter: presenter)

        router.viewController = view
        interactor.output = presenter
        return view
    }

    func back() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
