//
//  ViewController.swift
//  UNNotificationContentExtensions
//
//  Created by Erica Millado on 4/30/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
  
  @IBOutlet weak var responseLabel: UILabel!
  
  @IBOutlet weak var friendImage: UIImageView!
  @IBAction func triviaBtnTapped(_ sender: Any) {

    let friendsContent = UNMutableNotificationContent()
    friendsContent.title = "Friends Quiz!"
    friendsContent.subtitle = "Can you identify the Friend with his quote?"
    friendsContent.body = "'PIVOTTTT!!'"
    friendsContent.badge = 1
    friendsContent.categoryIdentifier = "friendsQuizCategory"
    //1 -
    friendsContent.sound = UNNotificationSound.default()
    
    let quizTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
    
    let quizRequestIdentifier = "friendsQuiz"
    let request = UNNotificationRequest(identifier: quizRequestIdentifier, content: friendsContent, trigger: quizTrigger)
    
    UNUserNotificationCenter.current().add(request) { (error) in
      print(error as Any)
    }
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    UNUserNotificationCenter.current().delegate = self
  }




}

//MARK - UNNotification Delegate Methods
extension ViewController: UNUserNotificationCenterDelegate {
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    
      completionHandler([.alert, .sound])
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
    //17 -
    if response.actionIdentifier == "ross" {
      responseLabel.text = "That's the correct answer!"
      friendImage.image = #imageLiteral(resourceName: "ross")
    } else if response.actionIdentifier == "chandler" {
      responseLabel.text = "Could you BE more wrong!?"
      friendImage.image = #imageLiteral(resourceName: "chandler")
    } else {
      responseLabel.text = "Try again... or go eat a sandwich."
      friendImage.image = #imageLiteral(resourceName: "joey")
    }
    completionHandler()
  }

}

