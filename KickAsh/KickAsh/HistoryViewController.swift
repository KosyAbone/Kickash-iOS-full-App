//
//  HistoryViewController.swift
//  KickAsh
//
//  Created by KOSSY on 2023-12-04.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var historyData: [(date: String, totalCigars: Int)] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self
            fetchSmokingHistory()
        }
        
        func fetchSmokingHistory() {
            // Perform API call to fetch smoking history data
            guard let url = URL(string: "https://api-kickash-8fefbb641f24.herokuapp.com/smoke/history") else {
                print("Invalid API endpoint")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            // Get the JWT token from UserDefaults (stored it after login/authentication)
            let token = UserDefaults.standard.string(forKey: "AuthToken")
            
            // Set the JWT token in the Authorization header
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(HistoryResponse.self, from: data)
                    self?.historyData = result.history.map { ($0.date, $0.totalCigars) }
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            
            task.resume()
        }
        
        // MARK: - Table View Data Source
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return historyData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell
            
            let history = historyData[indexPath.row]
            cell.dateSmokedTextField.text = formatDateString(history.date)
            cell.countTextField.text = "\(history.totalCigars)"
            
            return cell
        }
        
        // Helper function to format date string
        func formatDateString(_ dateString: String) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = formatter.date(from: dateString) {
                formatter.dateFormat = "MMM d, yyyy"
                return formatter.string(from: date)
            }
            return dateString
        }
    }

    struct HistoryResponse: Codable {
        let history: [History]
    }

    struct History: Codable {
        let date: String
        let totalCigars: Int
    }
