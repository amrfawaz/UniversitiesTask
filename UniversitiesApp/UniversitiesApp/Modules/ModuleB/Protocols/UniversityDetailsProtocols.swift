//
//  UniversityDetailsProtocols.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 03/05/2024.
//

protocol UniversityDetailsView: AnyObject {
    func show()
}

protocol UniversityDetailsPresenter: AnyObject {
    func viewDidLoad(view: UniversityDetailsView)
    func didTapRefresh()
    var universityName: String { get }
    var universityCountry: String { get }
    var universityState: String { get }
    var universityWebPage: String { get }
}

protocol UniversityDetailsInteractorInput: AnyObject {}

protocol UniversityDetailsInteractorOutput: AnyObject {}

protocol UniversityDetailsRouter: AnyObject {
    func back()
}

protocol UniversityDetailsRepo: AnyObject {}
