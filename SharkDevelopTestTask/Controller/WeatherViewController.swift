//
//  ViewController.swift
//  SharkDevelopTestTask
//
//  Created by Nikita Elizarov on 05/04/2018.
//  Copyright © 2018 Nikita Elizarov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Variables
    let API_KEY = "acd5df002b49b897247c3b919c181de1"
    let WEATHER_API = "https://api.darksky.net/forecast/"
    
    
    //Novosibirsk coordinates
    let latitude = "55.0411111"
    let longitude = "82.9344444"
    
    let cellIdentifier = "weatherForecastCell"
    var weatherForecast = [WeatherForecastDataModel]()
    
    
    //MARK - Outlets
    @IBOutlet weak var weatherSummary: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive(notification:)),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
    }
    
    @objc func applicationDidBecomeActive(notification: NSNotification) {
        makeRequest()
    }
    
    
    func makeRequest(){
        activityIndicator.startAnimating()
        let url = WEATHER_API + ("\(API_KEY)/\(latitude),\(longitude)")
        weatherForecast.removeAll()
        getWeatherData(url: url)
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Networking
    func getWeatherData(url: String) {
        // Check if network currently available
        if Reachability.isConnectedToNetwork(){
        Alamofire.request(url).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJSON : JSON = JSON(response.result.value!)
                let jsonParser = JsonParser();
                let weatherModel = jsonParser.jsonToWeatherDataModel(json: weatherJSON)
                let weatherForecastModel = jsonParser.jsonToWeatherForecastArray(json: weatherJSON)
                
                let encodeWeatherData = NSKeyedArchiver.archivedData(withRootObject: weatherModel)
                let encodeForecastData = NSKeyedArchiver.archivedData(withRootObject: weatherForecastModel)
                UserDefaults.standard.set(encodeWeatherData, forKey: "weatherModel")
                UserDefaults.standard.set(encodeForecastData, forKey: "weatherForecastModel")
                
                self.updateCurrentWeatherData(weather: weatherModel)
                self.updateForecastWeatherData(weatherForecast: weatherForecastModel)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
            }
            
        // If network is not available - show the last updated information
        } else {
           showAlert(title: "No network connection", message: "Please check your internet connection and try again")
            
            let weatherData = UserDefaults.standard.data(forKey: "weatherModel")
            let forecastData = UserDefaults.standard.data(forKey: "weatherForecastModel")
            
            if (weatherData != nil || forecastData != nil) {
                let forecastModel = NSKeyedUnarchiver.unarchiveObject(with: forecastData!) as? [WeatherForecastDataModel]
                let weatherModel = NSKeyedUnarchiver.unarchiveObject(with: weatherData!) as? WeatherDataModel
                self.updateCurrentWeatherData(weather: weatherModel!)
                self.updateForecastWeatherData(weatherForecast: forecastModel!)
            }
        }
        activityIndicator.stopAnimating()
    }
    
    @IBAction func updateWeatherInformation(_ sender: Any) {
        makeRequest()
    }
    
    // MARK: - Update content
    func updateCurrentWeatherData(weather : WeatherDataModel) {
        temperatureLabel.text = "\(weather.temperature)°"
        weatherIcon.image = UIImage(named: WeatherConditionIconManager.updateWeatherIcon(condition: weather.weatherIcon))
        weatherSummary.text = weather.summary
        cityLabel.text = weather.city
    }
    
    func updateForecastWeatherData(weatherForecast: [WeatherForecastDataModel]){
        self.weatherForecast.append(contentsOf: weatherForecast)
        forecastTableView.reloadData()
    }
    
    
    //MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath) as? WeatherForecastCell
        let weatherForecast = self.weatherForecast[indexPath.row]
        
        cell?.weatherForecastIcon.image = UIImage(named: WeatherConditionIconManager.updateWeatherIcon(condition: weatherForecast.weatherIcon))
        cell?.weatherForecastDate.text = weatherForecast.time
        cell?.weatherForecastMaxTemperature.text = String (weatherForecast.highestTemperature)
        cell?.weatherForecastMinTemperature.text = String (weatherForecast.lowestTemperature)
        
        return cell!
    }
}
