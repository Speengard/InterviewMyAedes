//
//  Question.swift
//  TestMyAedes
//
//  Created by Riccardo Di Stefano on 20/04/24.
//

import Foundation
import SwiftUI

struct Question: Identifiable, Hashable{
    
    var id = UUID()
    var question: String
    var imageString: String? = nil
    var answers: [String]
    var correctAnswer: String
    var selectedAnswer: String? = nil
    var point: Int = 10
    
    var image: Image? {
        if let imageString {
            Image(imageString)
        }else {
            nil
        }
    }
    
    static var mockData: [Question] = [
    Question(question: "Qual'è la città più bella del mondo?", answers: [
    "Napoli",
    "Roma",
    "Milano",
    "Torino"
    ], correctAnswer: "Napoli"),
    Question(question: "Qual'è la città più brutta del mondo?", answers: [
    "Napoli",
    "Roma",
    "Milano",
    "Torino"
    ], correctAnswer: "Milano")
    
    ]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
