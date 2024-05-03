//
//  UniversitiesListInteractor.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 02/05/2024.
//

import Foundation
import NetworkManager
import AppConfigurations

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
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
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
