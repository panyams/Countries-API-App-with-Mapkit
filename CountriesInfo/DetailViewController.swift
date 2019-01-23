//
//  DetailViewController.swift
//  CountriesInfo
//
//  Created by Sridevi Panyam on 11/29/18.
//  Copyright © 2018 SP. All rights reserved.
//

import UIKit
import MapKit


class DetailViewController: UIViewController, MKMapViewDelegate, UIScrollViewDelegate {

    
    @IBOutlet weak var countriesMapView: MKMapView!
    
    @IBOutlet weak var capitalNameLabel: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var region: UILabel!
    
    @IBOutlet weak var subregion: UILabel!
    
    @IBOutlet weak var population: UILabel!
    
    @IBOutlet weak var demonym: UILabel!
    
    
    @IBOutlet weak var area: UILabel!
    
    @IBOutlet weak var flagButton: UIButton!
    
    
    
    @IBOutlet weak var nativeName: UILabel!
    
    @IBOutlet weak var currencyLbl: UILabel!
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        flagButton.layer.cornerRadius = 10
        
        print("\(currentCountries[myIndex].currencies)")
        let navBarText = currentCountries[myIndex].name
        navItem.title = navBarText
        let navigationBarAppearance = UINavigationBar.appearance()
        //navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.green]
        
        
        
        if navBarText.count > 20 && UIDevice.current.userInterfaceIdiom == .phone {
            navigationController?.navigationBar.prefersLargeTitles = false
            var fontSz: CGFloat = 6
            if navBarText.count > 32 {
                fontSz = 4
            }
            
            let navBarfont = UIFont(name: "Helvetica", size: fontSz)
            navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.font: navBarfont!]
        }
        
        
        currencyLbl.text = "Currency Space"
        
        capitalNameLabel.text = "CAPITAL: " + currentCountries[myIndex].capital
        region.text = "REGION: " + currentCountries[myIndex].region
        subregion.text = "SUB REGION: " + currentCountries[myIndex].subregion
        let populationStr = "POPULATION: " + String(describing: currentCountries[myIndex].population)
        population.text = populationStr
        demonym.text = "DEMONYM: " + currentCountries[myIndex].demonym
        
        // area field getting rid of the optional text as prefix
        var areaStr = "AREA: "
        let areaDouble = currentCountries[myIndex].area
        if areaDouble != nil {
            print("\(areaDouble ?? 0.0)")
            areaStr = areaStr + "\(areaDouble ?? 0.0)"
        }
        else
        {
            print("Area not calucluated LOL!")
        }
    
        //let areaStr = "AREA: \(String(describing: areaDouble))"
        
        area.text = areaStr
        
        nativeName.text = "NATIVE NAME: " + currentCountries[myIndex].nativeName
        
        //currency fields
        //currencyLbl.text = ""
        //currencyLbl.text = ("\(currentCountries[myIndex].currencies)")
        var currencyText = "CURRENCIES: \n"
        
        for cur in currentCountries[myIndex].currencies {
            if cur.code != nil {
                print(cur.code ?? "none")
                currencyText += "CODE: " + cur.code! + ","
            }
            if cur.name != nil {
                print(cur.name ?? "none")
                currencyText += " NAME: " + cur.name! + ","
            }
            if cur.symbol != nil {
                print(cur.symbol ?? "none")
                currencyText  += " SYMBOL: " + cur.symbol! + "\n"
            }
            
            
            
        }
        
        currencyLbl.text = currencyText
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentCountries[myIndex].latlng.count == 2 {
            let initialLocation = CLLocation(latitude: currentCountries[myIndex].latlng[0], longitude: currentCountries[myIndex].latlng[1])
            centerMapOnLocation(location: initialLocation)
        }
    }
    
    let regionRadius: CLLocationDistance = 9000000
    
    
    
    func centerMapOnLocation(location: CLLocation) {
        if currentCountries[myIndex].latlng.count == 2 {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        countriesMapView.setRegion(coordinateRegion, animated: true)
        
        let countryName = MKPointAnnotation()
        countryName.title = currentCountries[myIndex].name
        countryName.coordinate = CLLocationCoordinate2D(latitude: currentCountries[myIndex].latlng[0], longitude: currentCountries[myIndex].latlng[1])
        countriesMapView.addAnnotation(countryName)
        }
        
    }
    
    
    @IBAction func flagBtnTapped(_ sender: UIButton) {
        if let url = URL(string: currentCountries[myIndex].flag),
            UIApplication.shared.openURL(url) {
            print("default browser was successfully opened")
            
        }
    }
    
    
    
}
