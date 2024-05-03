//
//  UniversityDetailsPresenter.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 03/05/2024.
//

import Foundation
import UIKit

final class UniversityDetailsPresenterImplementation: UniversityDetailsPresenter {
    private weak var view: UniversityDetailsView?
    private let university: University
    private let router: UniversityDetailsRouter
    private let interactor: UniversityDetailsInteractorInput

    var universityName: String {
        university.name
    }

    var universityCountry: String {
        university.country
    }
    var universityState: String {
        university.state ?? ""
    }
    var universityWebPage: String {
        university.webPages.first ?? ""
    }

    init(
        university: University,
        router: UniversityDetailsRouter,
        interactor: UniversityDetailsInteractorInput
    ) {
        self.university = university
        self.router = router
        self.interactor = interactor
    }

    func viewDidLoad(view: UniversityDetailsView) {
        self.view = view
        view.show()
    }

    func didTapRefresh() {
        router.back()
    }
}

extension UniversityDetailsPresenterImplementation: UniversityDetailsInteractorOutput {}
