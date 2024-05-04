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

    private let networkٍRepository: UniversitiesListNetworkRepository
    private let realmRepository: UniversitiesListRealmRepository

    init(
        networkٍRepository: UniversitiesListNetworkRepository,
        realmRepository: UniversitiesListRealmRepository
    ) {
        self.networkٍRepository = networkٍRepository
        self.realmRepository = realmRepository
    }

    func fetchUniversities() {
        networkٍRepository.fetchUniversities { [weak self] universities, error in
            if let universities {
                DispatchQueue.main.async {
                    self?.realmRepository.cacheUniversities(universities: universities)
                }
                self?.output?.fetchUniversitiesSuccess(universities: universities)
            } else {
                if let error {
                    DispatchQueue.main.async {
                        self?.realmRepository.fetchCachedUniversities { universities, realmError in
                            if let universities {
                                self?.output?.fetchUniversitiesSuccess(universities: universities)
                            } else {
                                self?.output?.fetchUniversitiesFailure(error: error)
                            }
                        }
                    }
                }
            }
        }
    }
}

final class UniversitiesListNetworkRepositoryImplementation: UniversitiesListNetworkRepository {
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
            case .failure(let networkError):
                completion(nil, networkError)
            }
        }
    }
}

class UniversitiesListRealmRepositoryImplementation: UniversitiesListRealmRepository {
    func cacheUniversities(universities: [University]) {
        let realmObjects = universities.map { university in
            return RealmUniversity(university: university)
        }
        RealmManager.shared.save(realmObjects)
    }
    
    func fetchCachedUniversities(completion: @escaping ([University]?, Error?) -> Void) {
        let realmObjects: [RealmUniversity] = RealmManager.shared.load(RealmUniversity.self)
        let universities = realmObjects.map { realmUniversity in
            return University(realmUniversity: realmUniversity)
        }
        completion(universities, nil)
    }
}

extension UniversitiesListNetworkRepositoryImplementation: Request {
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
