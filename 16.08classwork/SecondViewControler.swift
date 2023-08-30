//
//  SecondViewControler.swift
//  16.08classwork
//
//  Created by Akerke on 16.08.2023.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    var name = "Akerke"
    var countries: [Country] = []
    
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let activityIndicator = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        makeConstraints()
        fetchData()
    }
}

private extension SecondViewController {
    func setupScene() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        activityIndicator.style = .large
        tableView.delegate = self
        tableView.dataSource = self
    }
    func makeConstraints() {
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    func fetchData() {
        if let url = URL(string: "https://api.nationalize.io/?name=\(name)") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    
                }
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                   let decoder = JSONDecoder()
                    let decodedData = try! decoder.decode(NationResponse.self, from: data)
                    self.countries = decodedData.country
                    DispatchQueue.main.async {
                    self.tableView.reloadData()
                    }
                    
                }
            }
            
            task.resume()
        }

    }
    private func flag(from country:String) -> String {
            let base : UInt32 = 127397
            var s = ""
            for v in country.uppercased().unicodeScalars {
                s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
            }
            return s
        }
    
    private func countryName(from countryCode: String) -> String? {
            if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
                return name
            } else {
                return nil
            }
        }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let countryId = countries[indexPath.row].countryID
        let probability = countries[indexPath.row].probability
        let flag = flag(from: countryId)
        let countryName = countryName(from: countryId)
        let result = " \(flag) \(countryName ?? "") \(probability * 100)%"
        cell.textLabel?.text = result
        return cell
    }
    }
