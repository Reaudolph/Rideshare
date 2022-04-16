//
//  SearchViewController.swift
//  UwUber
//
//  Created by Hrishikesh Vikram on 4/16/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import FloatingPanel

class SearchViewController : UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    private let label: UILabel={
        let label = UILabel()
        label.text = "Where To"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
   private let field : UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Destination"
        field.backgroundColor = .tertiarySystemBackground
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        return field
    }()
    
    var locations = [Location]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        // Notify map controller to show pin
        let coordinate = locations[indexPath.row].coordinates
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder()
        if let text = field.text, !text.isEmpty {
            LocationManager.shared.findLocations(with:text){[weak self] locations in
                DispatchQueue.main.async {
                    self?.locations  = locations
                    self?.tableView.reloadData()
                }
                
        }
    }
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(field)
        
      
        tableView.delegate = self
        tableView.dataSource = self
        field.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 10, y: 20+label.frame.size.width, width:view.frame.size.width-20 , height:50)
        let tableY: CGFloat = field.frame.origin.y+field.frame.size.height+5
        tableView.frame = CGRect(x: 0, y: tableY, width: view.frame.size.width, height: view.frame.size.height)
    }
    
}
