//
//  UniversityDetailsInteractor.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 03/05/2024.
//

import Foundation

final class UniversityDetailsInteractor: UniversityDetailsInteractorInput {
    weak var output: UniversityDetailsInteractorOutput?

    private let repo: UniversityDetailsRepo

    init(repo: UniversityDetailsRepo) {
        self.repo = repo
    }
}

final class UniversityDetailsRepoImplementation: UniversityDetailsRepo {}
