//
//  QuestionViewModel.swift
//  TestMyAedes
//
//  Created by Riccardo Di Stefano on 20/04/24.
//

import Foundation
import SwiftUI

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var path: NavigationPath
    @Published var highScore: Int = 0
    @Published var currentScore: Int = 0
    
    init() {
        self.path = NavigationPath()
        self.questions = fetchQuestions()
        retrieveHighScore()
    }
    
    
    private func fetchQuestions() -> [Question] {
        return Question.mockData
    }
    
    public func addToScore(_ score: Int) {
        self.currentScore += score
        
    }
    
    public func retrieveHighScore() {
        self.highScore = UserDefaults.standard.integer(forKey: "HighScore")
    }
    
    public func saveScore() {
        
        if(currentScore > highScore) {
            UserDefaults.standard.set(currentScore, forKey: "HighScore")
        }
        retrieveHighScore()
    }
    
}
