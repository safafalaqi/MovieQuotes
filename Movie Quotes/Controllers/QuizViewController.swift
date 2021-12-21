//
//  QuizViewController.swift
//  Movie Quotes
//
//  Created by Safa Falaqi on 21/12/2021.
//

import UIKit
import SearchTextField

class QuizViewController: UIViewController{
   
    

    @IBOutlet weak var quoteLabel: UILabel!
    

    @IBOutlet weak var guessField: SearchTextField!
    
    @IBOutlet weak var scoreLabel: UILabel!
    var correctAnswer = ""
    var index = 0
    var score = 0
    var currentMovie = selectedMovies[0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        guessField.filterStrings(suggestionsArray)
       
        quoteLabel.text = currentMovie.quote
        
        
    //Looks for single or multiple taps.
     let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

    //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
    //tap.cancelsTouchesInView = false

    view.addGestureRecognizer(tap)
    }
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func checkGuess(_ sender: UIButton) {
        dismissKeyboard()
        index+=1
            if currentMovie.movie == guessField.text {
                score+=1
                scoreLabel.text = "Score: \(score)"
                guessField.text = ""
                nextQuestuion()
            } else{
                
                guessField.text = ""
                let alert = UIAlertController(title: "", message: "The correct answer is \(currentMovie.movie)" , preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                nextQuestuion()
            }
    }
        
        func nextQuestuion(){
            if index < selectedMovies.count
            {
                //go to next question
                currentMovie = selectedMovies[index]
                quoteLabel.text = currentMovie.quote
            }
            else{
                let alert = UIAlertController(title: "End of Game ", message: "Your total score is \(score)" , preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:  { action in
                        self.performSegue(withIdentifier: "toCollection", sender: self)
                        selectedMovies.removeAll()
                    }))
                self.present(alert, animated: true, completion: nil)
            }
                
            
            
                
        }
    
    @IBAction func cancelCurrentGamePressed(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "Cancel the current game?", message: "your score will not be saved", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Re-Pick Movies", style: .default, handler: { action in
            
            self.performSegue(withIdentifier: "toCollection", sender: self)
            print("size before delete: \(selectedMovies.count) ")
            selectedMovies.removeAll()
            print(" selected remove all size now: \(selectedMovies.count)")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
        }))
        
        self.present(alert, animated: true)
        
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "", message: "The correct answer is \(currentMovie.movie)" , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler:  { action in
            
            self.index += 1
            if self.index < selectedMovies.count
            {
                //go to next question
                self.currentMovie = selectedMovies[self.index]
                self.quoteLabel.text = self.currentMovie.quote
                self.guessField.text = ""
            }else{
                self.performSegue(withIdentifier: "toCollection", sender: self)
                selectedMovies.removeAll()
            }
            
        }))
    
        self.present(alert, animated: true, completion: nil)
       
        
    }
    
}
