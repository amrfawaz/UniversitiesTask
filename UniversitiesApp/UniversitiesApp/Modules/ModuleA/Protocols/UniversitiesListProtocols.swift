//
//  UniversitiesListProtocols.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 02/05/2024.
//

protocol UniversitiesListView: AnyObject {
    func show()
    func showError(errorMessage: String?)
    func startLoadingAnimation()
    func stopLoadingAnimation()
}

protocol UniversitiesListPresenter: AnyObject {
    var universitiesList: [University] { get }
    func viewDidLoad(view: UniversitiesListView)
    func viewWillAppear()
    func didTapUniversity(at index: Int)
}

protocol UniversitiesListInteractorInput: AnyObject {
    func fetchUniversities()
}

protocol UniversitiesListInteractorOutput: AnyObject {
    func fetchUniversitiesSuccess(universities: [University])
    func fetchUniversitiesFailure(error: Error?)
}

protocol UniversitiesListRouter: AnyObject {
    func navigateToUniversityDetails(university: University)
}

protocol UniversitiesListRepo: AnyObject {
    func fetchUniversities(completion: @escaping ([University]?, Error?) -> Void)
}
