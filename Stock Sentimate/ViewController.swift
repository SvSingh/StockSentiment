//
//  ViewController.swift
//  Stock Sentimate
//
//  Created by SV Singh on 2022-03-15.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var sentimentalLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    
    let swifter = Swifter(consumerKey: "wag1Dh1OdU8B3tRgZS0rDoMqz", consumerSecret: "26xMJ8QiQwuz4D0CtL0s5AbkMv6n7Gjtk84Lii23LOXaO8N8Fp")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func predictPressed(_ sender: UIButton) {
        
        var tweets = [TweetSentimentClassifierInput]()
        var sentiment = 0
        
        if  let searchText = textField.text {
            swifter.searchTweet(using: searchText,lang: "en",count: 100, tweetMode: .extended) { results, searchMetadata in
                
                
                
                for i in 0..<100 {
                    let tweet = results[i]["full_text"].string ?? "Error retriveing the String"
                    let TweetClassifierinout = TweetSentimentClassifierInput(text: tweet)
                    tweets.append(TweetClassifierinout)
                }
                
               let prediction =  try! self.sentimentClassifier.predictions(inputs: tweets)
                
                
                for prediction in prediction {
                    if prediction.label == "Pos" {
                        sentiment += 1
                    }else if prediction.label == "Neg"{
                       sentiment -= 1
                    }
                        
                }
                
                if sentiment > 20 {
                    self.sentimentalLabel.text = "🤩"
                } else if sentiment > 10 {
                    self.sentimentalLabel.text = "😁"
                }
                else if sentiment > 10 {
                    self.sentimentalLabel.text = "😌"
                }
                else if sentiment == 10 {
                    self.sentimentalLabel.text = "😐"
                }
                else if sentiment > -10 {
                    self.sentimentalLabel.text = "😟"
                }
                else if sentiment > -20 {
                    self.sentimentalLabel.text = "😫"
                }
                else {
                    self.sentimentalLabel.text = "😡"
                }
                
                
            } failure: { error in
                print(error)
            }
        }
        
        
    }
    

}

