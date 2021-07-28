//
//  ViewController.swift
//  VirtusaWeatherApp
//
//  Created by Brenton Niebauer on 7/27/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var zipCodeTextField: UITextField!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var conditionImage: UIImageView!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var resultStackView: UIStackView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultStackView.isHidden = true
        //resultStackView.center.x -= view.bounds.width
    }

    @IBAction func onPress(_ sender: Any) {
        if let zipCode = zipCodeTextField.text {
            WeatherController.shared.fetchWeatherFor(zip: zipCode) { result in
                switch result {
                case .success(let res):
                    self.updateUI(results: res)
                case .failure(let error):
                    self.displayError(error, title: "Failed to get weather")
                }
            }
        }
        else {
            print("Nothing entered!")
        }
    }
    
    func updateUI(results: WeatherResponse) {
        DispatchQueue.main.async {
            self.tempLabel.text = "\(results.current!.temp_f)"
            self.locationLabel.text = results.location!.name
            self.conditionImage.image = self.getWeatherImage(results.current!.condition.code)
            UIView.animate(withDuration: 0.5) {
                self.resultStackView.isHidden = false
                self.resultStackView.center.x += self.view.bounds.width
            }
        }
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getWeatherImage(_ code: Int) -> UIImage {
        switch code {
        case 1000:
            return UIImage(systemName: "sun.max.fill")!
        case 1003...1030:
            return UIImage(systemName: "cloud.fill")!
        default:
            return UIImage(systemName: "cloud.bolt.rain.fill")!
        }
    }
}

