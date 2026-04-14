//
//  TeamQuizViewModel.swift
//  TeamQuiz
//
//  Created by yoonie on 4/14/26.
//

import Foundation
import Combine
import Observation


enum ScoreError: Error {
    case nagativeScore
}

@Observable
final class TeamQuizViewModel {
    let p1Publisher = PassthroughSubject<Int, Error>()
    let p2Publisher = PassthroughSubject<Int, Error>()
    var cancellables = Set<AnyCancellable>()
    
    var scoreP1: Int
    var scoreP2: Int
    var totalScore: Int
    var hasPassed: Bool {
        totalScore >= 10
    }
    
    init(scoreP1: Int = 0, scoreP2: Int = 0, totalScore: Int = 0) {
        self.scoreP1 = scoreP1
        self.scoreP2 = scoreP2
        self.totalScore = totalScore
        calculateScores()
    }
    
    func calculateScores() {
        let p1 = p1Publisher
            .tryMap { score in
                if score < 0 {
                    throw ScoreError.nagativeScore
                } else {
                    return score
                }
            }
            .replaceError(with: -1)
            .eraseToAnyPublisher()
        
        let p2 = p2Publisher
            .tryMap { score in
                if score < 0 {
                    throw ScoreError.nagativeScore
                } else {
                    return score
                }
            }
            .replaceError(with: -1)
            .eraseToAnyPublisher()
        
        p1.combineLatest(p2)
            .map { [weak self] (p1Score, p2Score) in
                guard let self else { return 0 }
                self.scoreP1 = p1Score
                self.scoreP2 = p2Score
                print(p1Score, p2Score)
                return p1Score + p2Score
            }
            .filter( { $0 >= 10 } )
            .removeDuplicates()
            .sink { [weak self] total in
                guard let self else {return}
                self.totalScore = total
            }
            .store(in: &cancellables)
    }
}
