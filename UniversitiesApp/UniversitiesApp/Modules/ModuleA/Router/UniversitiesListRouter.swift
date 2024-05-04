//
//  UniversitiesListRouter.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 02/05/2024.
//

import Foundation
import UIKit

final class UniversitiesListRouterImplementation: UniversitiesListRouter {
    weak var viewController: UniversitiesListViewController?
    
    func build() -> UIViewController {
        let router = UniversitiesListRouterImplementation()
        let networkٍRepository = UniversitiesListNetworkRepositoryImplementation()
        let realmRepository = UniversitiesListRealmRepositoryImplementation()
        let interactor = UniversitiesListInteractor(networkٍRepository: networkٍRepository, realmRepository: realmRepository)
        let presenter = UniversitiesListPresenterImplementation(router: router, interactor: interactor)
        let view = UniversitiesListViewController(presenter: presenter)

        router.viewController = view
        interactor.output = presenter
        return view
    }

    func navigateToUniversityDetails(university: University) {
        let universityDetailsViewController = UniversityDetailsRouterImplementation().build(university: university)
        viewController?.navigationController?.pushViewController(universityDetailsViewController, animated: true)
    }
}
