//
//  QuestionFactory.swift
//  05-QuizApp
//
//  Created by Daniel Hidalgo on 23/01/2020.
//  Copyright © 2020 HSN. All rights reserved.
//

import Foundation

class QuestionFactory {
    
    var questionsBank: Questions!
    
    init() {
        do{
            if let url = Bundle.main.url(forResource: "Questions", withExtension: "plist"){
                let data = try Data(contentsOf: url)
                self.questionsBank = try PropertyListDecoder().decode(Questions.self, from: data)
            }
        }catch{
            print(error)
        }
    }
    
    func getQuestion(index: Int) -> Question? {
        if (index < 0 || index >= self.questionsBank.questions.count) {
            return nil
        }
        return self.questionsBank.questions[index]
    }
    
    func getRandomQuestion() -> Question {
        let random = arc4random_uniform(UInt32(self.questionsBank.questions.count))
        return self.questionsBank.questions[Int(random)]
    }
    
}
