//
//  HomeViewController.swift
//  KickAsh
//
//  Created by Ilham Sheikh on 2023-08-10.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var smokingCounter: UIButton!
    
    @IBOutlet weak var smokeCounterLabel: UILabel!
    
    @IBOutlet weak var warningText: UILabel!
    
    @IBOutlet weak var smokeFreeTimerLabel: UILabel!
    
    var cigarettesSmoked : Int!

    var goalDays : Int!

    var cigarettesSmokedInPast : Int!

    var cigarettesAllowed : Int!
    
    var lastSmoked : Date!
    
    var timer: Timer?
    var smokeFreeCounter: Int = 0
    var lastSmokeFreeTime: Int = 0
    var username : String!
        
    var notificationsAllowed : Bool = false
    
    static var lastUpdateDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        
        username = UserDefaults.standard.string(forKey: "Username") ?? nil
        
        cigarettesSmoked = UserDefaults.standard.integer(forKey: "Cigarettes Smoked" + username!)
        
        smokeCounterLabel.text = String(cigarettesSmoked)
        
        cigarettesSmokedInPast = UserDefaults.standard.integer(forKey: QuestionnaireDataKey.question2 + username!)

        var userGoal = UserDefaults.standard.object(forKey: QuestionnaireDataKey.question8 + username!) as! Date
        getGoalDays(userGoal)

        getCustomisation()

        let cigNumber = String(cigarettesAllowed)
        let displayText = "Please smoke only " + cigNumber + " cigarettes today"
        warningText.text = displayText
        
        //to display the notification when the app is in foreground
        UNUserNotificationCenter.current().delegate = self
                
        checkForPermission()
        
        // Check and reset cigarettesSmoked at midnight
        resetCigarettesSmokedAtMidnight()


        print("View Loaded")
    }
    
    
    @IBAction func smokeCounter(_ sender: UIButton) {
        
        // Check if the API endpoint exists
            guard let url = URL(string: "https://api-kickash-8fefbb641f24.herokuapp.com/smoke/increment") else {
                print("Invalid API endpoint")
                return
            }
            
            // Create a URLRequest
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            
            // Get the JWT token from UserDefaults (stored it after login/authentication)
            let token = UserDefaults.standard.string(forKey: "AuthToken")
            
            // Set the JWT token in the Authorization header
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            
            // Create a URLSession task for the API request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                // Handle the API response here
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                // Parse the response data if needed
                if let data = data {
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: data, options: [])
                        if let responseDict = responseJSON as? [String: Any],
                           let currentCigarCount = responseDict["currentCigarCount"] as? Int {
                            DispatchQueue.main.async { [self] in
                                // Update UI & UserDefaults with the received currentCigarCount value
                                UserDefaults.standard.set(currentCigarCount, forKey: "Cigarettes Smoked" + username!)
                                self.smokeCounterLabel.text = "\(currentCigarCount)"
                            }
                        }
                    } catch {
                        print("Error parsing JSON: \(error)")
                    }
                }
            }
            
            // Perform the API request
            task.resume()
            
        // Reset timer
        resetTimer()
        
        if(notificationsAllowed){
            dispatchSmokeFreeTimeNotification()
        }
    }
    
    func resetCigarettesSmokedAtMidnight() {
            // Get the current date
            let currentDate = Date()

            // Compare the current date with the last update date
            if let lastUpdateDate = HomeViewController.lastUpdateDate,
               !Calendar.current.isDate(currentDate, inSameDayAs: lastUpdateDate) {
                // If it's a new day, reset cigarettesSmoked and update the last update date
                UserDefaults.standard.set(0, forKey: "Cigarettes Smoked" + username!)
                HomeViewController.lastUpdateDate = currentDate

                // Updating UI
                smokeCounterLabel.text = String(0)
            }
        }

    
    func getGoalDays(_ userGoal : Date){
        let todayDate = Date()

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day], from: todayDate, to: userGoal)

        goalDays = dateComponents.day

        print("Goal Days!!!", String(goalDays))
    }

    func getCustomisation(){
        if(cigarettesSmokedInPast != nil){
            if(goalDays <= 10){
                cigarettesAllowed = 0
            }
            else if (goalDays > 10 && goalDays <= 20){
                cigarettesAllowed = 1
            }
            else if (goalDays > 20 && goalDays <= 30){
                cigarettesAllowed = 2
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
            else if (goalDays > 30 && goalDays <= 40){
                cigarettesAllowed = 3
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
            else if (goalDays > 40 && goalDays <= 50){
                cigarettesAllowed = 4
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
            else if (goalDays > 50 && goalDays <= 60){
                cigarettesAllowed = 5
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
            else if (goalDays > 60 && goalDays <= 70){
                cigarettesAllowed = 6
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
            else if (goalDays > 70 && goalDays <= 80){
                cigarettesAllowed = 7
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
            else if (goalDays > 80 && goalDays <= 90){
                cigarettesAllowed = 8
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
        }
    }


    //starting smoke free timer
    func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
    
    //timer value
    @objc func updateCounter() {
           smokeFreeCounter += 1
           updateTimerLabel()
       }
    
    //reset timer to 0 on click
    func resetTimer() {
            timer?.invalidate()
            lastSmokeFreeTime = smokeFreeCounter
            smokeFreeCounter = 0
            updateTimerLabel()
            startTimer()
        }
    
    func updateTimerLabel() {
            let hours = smokeFreeCounter / 3600
            let minutes = (smokeFreeCounter % 3600) / 60
            let seconds = smokeFreeCounter % 60
            
            smokeFreeTimerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    
    func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings{settings in
            switch settings.authorizationStatus{
            case .authorized:
                self.dispatchNotification()
                self.notificationsAllowed = true
            case .denied:
                self.notificationsAllowed = false
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]){didAllow, error in
                    if didAllow{
                        self.dispatchNotification()
                        self.notificationsAllowed = true
                    }
                }
            default:
                return
            }
                   
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show the notification even when the app is in the foreground
        completionHandler([.alert, .sound])
    }
    
    func dispatchNotification(){
        guard let cigarettesSmoked = cigarettesSmoked else{
            print("No CigarretesSmoked Data found in userDefaults")
            return
        }
        
        let identifier = "daily-update"
        let title = "Daily Update"
        let body = "You have smoked " + String(describing: cigarettesSmoked) + "cigarettes today"
        let hour = 15
        let minute = 09
        let isDaily = true
                
        let notificationCenter = UNUserNotificationCenter.current()
                
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
                
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
                
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
    
    
    //sends a notification showing the last smoke free time duration
    func dispatchSmokeFreeTimeNotification(){
        let hours = lastSmokeFreeTime / 3600
        let minutes = (lastSmokeFreeTime % 3600) / 60
        let seconds = lastSmokeFreeTime % 60
            
        let identifier = "smoke-free-time"
        var title = "Good Going!"
        var body = ""
            
            
        if(hours == 0 && minutes == 0){
            title = "You can do better"
            body = "You were " + "\(seconds)" + " seconds smoke free"
        }
        else if(hours == 0){
            body = "You were " + "\(minutes)" + " minutes and " + "\(seconds)" + " seconds smoke free"
        }
        else if(minutes == 0 && seconds == 0){
            body = "You were " + "\(hours)" + " hours smoke free"
        }
        else if(minutes == 0){
            body = "You were " + "\(hours)" + " hours and " + "\(seconds)" + " seconds smoke free"
        }
        else if(seconds == 0){
            body = "You were " + "\(hours)" + " hours and " + "\(minutes)" + " minutes smoke free"
        }
        else {
            body = "You were " + "\(hours)" + " hours, " + "\(minutes)" + " minutes and " + "\(seconds)" + " seconds smoke free"
        }
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
        
    }

}
