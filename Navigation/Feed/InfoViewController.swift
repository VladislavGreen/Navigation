//
//  InfoVC.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//

import UIKit

class InfoViewController: UIViewController {
    
    
//    private enum LocalizedKeys: String {
////        case button = "InfoVC-button" // " A button from UI course "
////        case alert = "InfoVC-alert" //  "It's time to choose!"
////        case message = "InfoVC-message" // "Left or right? Press the button:"
////        case latinLabel = "InfoVC-latinLabel" // "Some latin text"
//        case orbitalLabel = "InfoVC-orbitalLabel" // "Tatooine orbital period"
//    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("InfoVC-button".localized, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.createColor(lightMode: .darkGray, darkMode: .lightGray)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let alertController = UIAlertController(
        title: "InfoVC-alert".localized,
        message: "InfoVC-message".localized,
        preferredStyle: .alert
    )
    
    
    private lazy var latinLabel: UILabel = {
        let label = UILabel()
        label.text = "InfoVC-latinLabel".localized
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var orbitalLabel: UILabel = {
        let label = UILabel()
        label.text = "InfoVC-orbitalLabel".localized
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tatooineResidentNames: [String] = []

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = view.backgroundColor
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TatooineResidentCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startURLSessionDataTask1()
    }
    
    func setupUI() {
        view.backgroundColor = .systemRed
        setupConstraints()
        setupAlertConfiguration()
        addTargets()
    }
    
    func setupConstraints() {
        view.addSubview(latinLabel)
        view.addSubview(orbitalLabel)
        view.addSubview(button)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            latinLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            latinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            orbitalLabel.topAnchor.constraint(equalTo: latinLabel.bottomAnchor, constant: 16),
            orbitalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: orbitalLabel.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAlertConfiguration() {
        alertController.addAction(UIAlertAction(title: "LEFT", style: .default, handler: { _ in
           print("LEFT")
        }))
        alertController.addAction(UIAlertAction(title: "RIGHT", style: .default, handler: { _ in
           print("RIGHT")
        }))
    }
    
    func addTargets() {
        button.addTarget(self, action: #selector(addTarget), for: .touchUpInside)
    }
    
    @objc func addTarget() {
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func startURLSessionDataTask1() {
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/") {
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let unwrappedData = data {
                    do {
                        let serializedDict = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        let array = serializedDict as? Array<Any>
                        
                        if let arrayMember28 = array?[28] as? [String : Any] {
                            
                            if let title = arrayMember28["title"] as? String {
                                DispatchQueue.main.async {
                                    self.latinLabel.text = title
                                    self.startURLSessionDataTask2()
                                }
                            }
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func startURLSessionDataTask2() {
        
        if let url = URL(string: "https://swapi.dev/api/planets/1") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let unwrappedData = data {
                    do {
                        let tatooine = try JSONDecoder().decode(Tatooine.self, from: unwrappedData)
                        DispatchQueue.main.async {
                            self.orbitalLabel.text = "InfoVC-orbitalLabel".localized + " = \(tatooine.orbitalPeriod)"
                            self.startURLSessionDataTask3()
                            self.setupUI()
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func startURLSessionDataTask3() {
        
        if let url = URL(string: "https://swapi.dev/api/planets/1") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let unwrappedData = data {
                    do {
                        let tatooine = try JSONDecoder().decode(Tatooine.self, from: unwrappedData)
                        let residents = tatooine.residents
                        
                        residents.forEach {
                            if let url = URL(string: $0) {
                                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                                    if let unwrappedData = data {
                                        do {
                                            let residentName = try JSONDecoder().decode(TatooineResidentName.self, from: unwrappedData)
                                            let name = residentName.name
                                            self.tatooineResidentNames.append(name)
                                            DispatchQueue.main.async {
                                                
                                                self.tableView.reloadData()
                                            }
                                        } catch let error {
                                            print(error)
                                        }
                                    }
                                }
                                task.resume()
                            }
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
}


extension InfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = tatooineResidentNames.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TatooineResidentCell", for: indexPath)
        cell.textLabel!.text = "\(tatooineResidentNames[indexPath.row])"
        return cell
    }

}
