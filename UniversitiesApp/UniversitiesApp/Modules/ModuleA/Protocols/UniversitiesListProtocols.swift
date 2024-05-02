//
//  UniversitiesListProtocols.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 02/05/2024.
//

import UIKit
import NetworkManager

protocol UniversitiesListView: AnyObject {
    func show()
    func showError(errorMessage: String?)
    func startLoadingAnimation()
    func stopLoadingAnimation()
}

protocol UniversitiesListPresenter: AnyObject {
    var universitiesList: [University] { get }
    func viewDidLoad(view: UniversitiesListView)
}

protocol UniversitiesListInteractorInput: AnyObject {
    func fetchUniversities()
}

protocol UniversitiesListInteractorOutput: AnyObject {
    func fetchUniversitiesSuccess(universities: [University])
    func fetchUniversitiesFailure(error: Error?)
}

protocol UniversitiesListRouter: AnyObject {}

protocol UniversitiesListRepo: AnyObject {
    func fetchUniversities(completion: @escaping ([University]?, Error?) -> Void)
}
