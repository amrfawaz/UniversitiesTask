//
//  UniversityDetailsInteractor.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 03/05/2024.
//

import Foundation

final class UniversityDetailsInteractor: UniversityDetailsInteractorInput {
    private let repo: UniversityDetailsRepo
    weak var output: UniversityDetailsInteractorOutput?

    init(repo: UniversityDetailsRepo) {
        self.repo = repo
    }
}

final class UniversityDetailsRepoImplementation: UniversityDetailsRepo {}
