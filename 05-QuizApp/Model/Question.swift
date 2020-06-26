//
//  Question.swift
//  05-QuizApp
//
//  Created by Daniel Hidalgo on 23/01/2020.
//  Copyright © 2020 HSN. All rights reserved.
//

import Foundation


class Question: CustomStringConvertible, Codable {
    
    let question : String
    let answer : Bool
    let answerExplanation: String
    
    /*
    enum CodingKeys : String, CodingKey {
        case text = "question"
        case answer = "answer"
        case answerExplanation = "answerExplanation"
    }*/
    
    var description: String{
        return "Text: \(self.question) - Answer: \(self.answer)"
    }
    
}

struct Questions: Codable {
    var questions: [Question]
}
