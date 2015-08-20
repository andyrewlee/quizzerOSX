//
//  ViewController.swift
//  quizzer
//
//  Created by Jae Hoon Lee on 8/19/15.
//  Copyright © 2015 Jae Hoon Lee. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    let socket = SocketIOClient(socketURL: "http://localhost:5000")
    let speechSynthesizer = NSSpeechSynthesizer()
    var quizItems = [QuizItem]()
    
    var currentQuestion = 0
    var currentA = 0
    var currentB = 0
    var currentC = 0
    var currentD = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizItems = loadInitialQuestionItems()
        updateUI()
        
        socket.connect()
        
        socket.on("connect") { data, ack in
            print("OSX::WE ARE USING SOCKETS!")
        }
        
        socket.on("A") { data, ack in
            self.currentA += 1
            self.updateUI()
        }
        
        socket.on("B") { data, ack in
            self.currentB += 1
            self.updateUI()
        }
        
        socket.on("C") { data, ack in
            self.currentC += 1
            self.updateUI()
        }
        
        socket.on("D") { data, ack in
            self.currentD += 1
            self.updateUI()
        }
    }

    @IBOutlet weak var questionLabel: NSTextField!

    @IBOutlet weak var answerALabel: NSTextField!
    @IBOutlet weak var answerBLabel: NSTextField!
    @IBOutlet weak var answerCLabel: NSTextField!
    @IBOutlet weak var answerDLabel: NSTextField!
    
    @IBOutlet weak var responseALabel: NSTextField!
    @IBOutlet weak var responseBLabel: NSTextField!
    @IBOutlet weak var responseCLabel: NSTextField!
    @IBOutlet weak var responseDLabel: NSTextField!
    
    @IBAction func previousButtonPressed(sender: NSButton) {
        currentA = 0
        currentB = 0
        currentC = 0
        currentD = 0
        
        if currentQuestion > 0 {
            currentQuestion--
            updateUI()
        }
    }
    
    @IBAction func answerButtonPressed(sender: NSButton) {
        speechSynthesizer.startSpeakingString("The answer is \(quizItems[currentQuestion].answer)")
    }
    
    @IBAction func nextButtonPressed(sender: NSButton) {
        currentA = 0
        currentB = 0
        currentC = 0
        currentD = 0
        
        if currentQuestion < quizItems.count - 1 {
            currentQuestion++
            updateUI()
        }
    }
    
    func updateUI() {
        responseALabel.stringValue = String(currentA)
        responseBLabel.stringValue = String(currentB)
        responseCLabel.stringValue = String(currentC)
        responseDLabel.stringValue = String(currentD)
        
        questionLabel.stringValue = quizItems[currentQuestion].question
    }
    
    func loadInitialQuestionItems() -> [QuizItem] {
        var output = [QuizItem]()
        
        output.append(QuizItem(question: "You can focus on things that are barriers or you can focus on scaling the wall or redefining the problem.", answer: "Tim Cook"))
        
        output.append(QuizItem(question: "What we make testifies who we are. People can sense care and can sense carelessness. This relates to respect for each other and carelessness is personally offensive.", answer: "Jony Ive"))
        
        output.append(QuizItem(question: "The thing is, I don't want to be sold to when I walk into a store. I want to be welcomed.", answer: "Angela Ahrendts"))
        
        output.append(QuizItem(question: "Design is not just what it looks like and feels like. Design is how it works.", answer: "Steve Jobs"))
        
        output.append(QuizItem(question: "Everyone in the world should have a trench coat, and there should be a trench coat for everyone in the world. It does not matter your age; it doesn't matter your gender.", answer: "Angela Ahrendts"))
        
        output.append(QuizItem(question: "Life is fragile. We're not guaranteed a tomorrow so give it everything you've got.", answer: "Tim Cook"))
        
        output.append(QuizItem(question: "I learned that focus is key. Not just in your running a company, but in your personal life as well.", answer: "Tim Cook"))
        
        return output
    }
}