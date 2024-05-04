//
//  UniversitiesListInteractor.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 02/05/2024.
//

import Foundation
import NetworkManager
import AppConfigurations
import RealmManager

final class UniversitiesListInteractor: UniversitiesListInteractorInput {
    weak var output: UniversitiesListInteractorOutput?

    private let repo: UniversitiesListRepo

    init(repo: UniversitiesListRepo) {
        self.repo = repo
    }

    func fetchUniversities() {
        repo.fetchUniversities { universities, error in
            if let universitiesList = universities {
                self.output?.fetchUniversitiesSuccess(universities: universitiesList)
            } else {
                self.output?.fetchUniversitiesFailure(error: error)
            }
        }
    }
}

final class UniversitiesListRepoImplementation: UniversitiesListRepo {
    private enum UniversitiesListEndPoint: String {
        case search = "/search"
    }

    func fetchUniversities(completion: @escaping ([University]?, Error?) -> Void) {
        guard let request = urlRequest
        else { return }

        NetworkManager.shared.fetchData(request: request) { (result: Result<[University], NetworkError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.cacheUniversities(universities: data)
                }
                completion(data, nil)
            case .failure(let error):
                DispatchQueue.main.async {
                    let universities = self.fetchCachedUniversities()
                    
                    if universities.count > 0 {
                        completion(universities, nil)
                    } else {
                        completion(nil, error)
                    }
                }
            }
        }
    }
}

extension UniversitiesListRepoImplementation: UniversitiesListRealmRepo {
    func cacheUniversities(universities: [University]) {
        let realmObjects = universities.map { university in
            return RealmUniversity(university: university)
        }
        RealmManager.shared.save(realmObjects)
    }
    
    func fetchCachedUniversities() -> [University] {
        let realmObjects: [RealmUniversity] = RealmManager.shared.load(RealmUniversity.self)
        let universities = realmObjects.map { realmUniversity in
            return University(realmUniversity: realmUniversity)
        }
        return universities
    }
}

extension UniversitiesListRepoImplementation: Request {
    var parametrs: Any? {
        ["country": "United Arab Emirates"]
    }

    var urlRequest: URLRequest? {
        let urlString = AppConstants.baseUrl.rawValue + UniversitiesListEndPoint.search.rawValue

        guard let url = URL(string: urlString)
        else { return nil}

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if let queryParams = parametrs as? [String: String] {
            components?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let finalURL = components?.url else {
            return nil
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = HTTPMethod.get.rawValue
        return request
    }
}
