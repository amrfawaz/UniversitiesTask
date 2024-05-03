//
//  UniversitiesListPresenter.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 02/05/2024.
//

import Foundation
import UIKit

final class UniversitiesListPresenterImplementation: UniversitiesListPresenter{
    private weak var view: UniversitiesListView?
    private let router: UniversitiesListRouter
    private let interactor: UniversitiesListInteractorInput
    private(set) var universitiesList = [University]()

    init(
        router: UniversitiesListRouter,
        interactor: UniversitiesListInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }

    func viewDidLoad(view: UniversitiesListView) {
        self.view = view
    }

    func viewWillAppear() {
        interactor.fetchUniversities()
    }

    func didTapUniversity(at index: Int) {
        let university = universitiesList[index]
        router.navigateToUniversityDetails(university: university)
    }
}

extension UniversitiesListPresenterImplementation: UniversitiesListInteractorOutput {
    func fetchUniversitiesSuccess(universities: [University]) {
        universitiesList = universities
        self.view?.stopLoadingAnimation()
        self.view?.show()
    }

    func fetchUniversitiesFailure(error: Error?) {
        self.view?.stopLoadingAnimation()
        self.view?.showError(
            errorMessage: error?.localizedDescription
        )
    }
}
