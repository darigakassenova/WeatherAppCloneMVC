//
//  ViewController.swift
//  WeatherAppClone
//
//  Created by Dariga on 13.05.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var forecastStackView: UIStackView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var todayMaxMinLabel: UILabel!
    @IBOutlet weak var BackgroundForecastView: UIView!
    @IBOutlet weak var backgroundWeekForecastView: UIView!
    @IBOutlet weak var weekForecastStackView: UIStackView!
    @IBOutlet weak var menuButton: UIButton!
    
    private let dataSource: ForecastDataSource = .init()
    
    private var cityModel: CityModel? {
        didSet {
            configureUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BackgroundForecastView.layer.cornerRadius = 8
        BackgroundForecastView.backgroundColor = Color.blueBackgroundColor
        getData()
    }
    
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
//        print("Button was tapped")
        let viewController = CitiesViewController()
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    private func configureUI(){
        guard let cityModel = cityModel else { return }
        
        cityNameLabel.text = cityModel.name
        currentTemperatureLabel.text = cityModel.currentTemperature.withCelcius
        conditionLabel.text = cityModel.condition.text
        
        guard let maxTemperature = cityModel.maxTemperature, let minTemperature = cityModel.minTemperature else { return }
        
        todayMaxMinLabel.text = "Max.: \(maxTemperature.withCelcius), min.: \(minTemperature.withCelcius)"
        cityModel.forecastDays.forEach {
            let dayForecastView = WeekItemView()
            dayForecastView.configure(model: $0)
            weekForecastStackView.addArrangedSubview(dayForecastView)
        }
        
        guard let currentDay = cityModel.forecastDays.first else { return }
        
        currentDay.hour.forEach {
            let forecastItemView = ForecastItemView()
            forecastItemView.configure(model: $0)
            forecastStackView.addArrangedSubview(forecastItemView)
        }
    }
    
    private func getData(){
        dataSource.getForecast(cityName: cityModel?.name ?? "Almaty", days: 10) { result in
            switch result {
            case .success(let city):
                DispatchQueue.main.async {
                    self.cityModel = city
                }
            case .failure(let error):
                print("error = \(error.localizedDescription)")
            }
        }
    }
}

extension ViewController: CitiesViewControllerDelegate {
    func didSelectCity(_ city: SearchCityModel) {
//        dump(city)
        cityModel?.name = city.name
        getData()
    }
}
