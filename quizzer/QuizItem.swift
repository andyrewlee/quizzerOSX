//
//  QuizItem.swift
//  quizzer
//
//  Created by Jae Hoon Lee on 8/19/15.
//  Copyright © 2015 Jae Hoon Lee. All rights reserved.
//

import Foundation

class QuizItem {
    let question: String
    let answer: String
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}