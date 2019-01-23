//
//  ViewController.swift
//  CountriesInfo
//
//  Created by Sridevi Panyam on 8/12/18.
//  Copyright © 2018 SP. All rights reserved.
//

import UIKit

struct Countries: Codable {
    let name: String
    let capital: String
    var topLevelDomain: [String]
    var alpha2Code: String
    var alpha3Code: String
    var altSpellings: [String]
    let region: String
    var subregion: String
    var population: Int
    var latlng: [Double]
    var demonym: String
    var area: Double?
    var gini: Double?
    var timezones: [String]
    var borders: [String]
    var nativeName: String
    var numericCode: String?
    var currencies: [Currency]
    
    var flag: String
    
}

struct Currency: Codable {
    let code: String?
    let name: String?
    let symbol: String?
}



var countries = [Countries]()
var currentCountries = [Countries]()
var borderArray = [String]()
var myIndex = 0

class ViewController: UIViewController {
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //set up navigation bar title size
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        //set the tableview delegate and datasource
        countryTableView.delegate = self
        countryTableView.dataSource = self
        searchBar.delegate = self
        hideKeyBoardWhenTapped()
       
        //set up parsing the JSON
        let jsonString = "http://restcountries.eu/rest/v2/all"
        guard let url = URL(string: jsonString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {return}
//            let dataAsString = String(data: data, encoding: .utf8)
//            print(dataAsString)
            do {
                countries = try JSONDecoder().decode([Countries].self, from: data)
                currentCountries = countries
                DispatchQueue.main.async {
                    self.countryTableView.reloadData()
                }
                print(countries)
                
            }
            catch let jsonErr {
                print("JSON serialization error", jsonErr)
            }
            
            
        }.resume()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set up navigation bar title size
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func barBtnTapped(_ sender: UIBarButtonItem) {
        let url = URL(string: "https://bit.ly/2H9twSU")
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}



extension ViewController {
    
    func hideKeyBoardWhenTapped() {
        let  tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyBoard(_:)))
        tap.numberOfTapsRequired = 1
        tap.isEnabled = true
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        //view.endEditing(true)
       view.endEditing(true)
        if let nav = self.navigationController {
            nav.view.endEditing(true)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("In the rowsin Section \(countries.count)")
        
        return currentCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cellCountry", for: indexPath) as! NotNibTableViewCell
        cell.countryNameLB.text = currentCountries[indexPath.row].name
        
        //The headline label uses the preferred, default 'headline' font.  Thhis font is already scaled appropriately and supports Dynamic Type.  All that's needed to have the label automatically adjust this font, is to enable 'adjustFontForContentSizeCategory'
        /*cell.countryNameLB.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.countryNameLB.adjustsFontForContentSizeCategory = true
        cell.countryNameLB.numberOfLines = 1
 */
        
        //to have labels extend full width of the cell(within default margins); one labels leading and trailing anchors with the first one.
        /*cell.countryNameLB.leadingAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        cell.countryNameLB.trailingAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        cell.countryNameLB.firstBaselineAnchor.constraintEqualToSystemSpacingBelow(cell.contentView.layoutMarginsGuide.topAnchor, multiplier: 1).isActive = true
        
        cell.contentView.layoutMarginsGuide.bottomAnchor.constraintEqualToSystemSpacingBelow(cell.countryNameLB.lastBaselineAnchor, multiplier: 1).isActive = true
        //cell.countryNameLB.bottomAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        //cell.contentView.addSubview(cell.countryNameLB)
        
        */
        
        
        print("\(currentCountries[indexPath.row].name)")
        print("\(currentCountries[indexPath.row].flag)")
        print("\(currentCountries[indexPath.row].latlng)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(currentCountries[indexPath.row].capital)
        
        myIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: self)
    }
  
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentCountries = countries
            countryTableView.reloadData()
            return
        }
        currentCountries = countries.filter({ (countries: Countries) -> Bool in

            return countries.name.lowercased().contains(searchText.lowercased())

        })
        
        countryTableView.reloadData()
        
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    
    
}



