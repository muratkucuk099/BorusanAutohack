//
//  ViewController.swift
//  BorusanAutoHack
//
//  Created by Mac on 10.12.2023.
//

import UIKit

class Mainpage: UIViewController {
    
    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let openAICall = OpenAIAPIModel()
    let mainpageViewModel = MainpageViewModel()
    var carList = [Car]()
    var selectedCar: Car? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indicator.isHidden = true
        reportLabel.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "car")
        carList.append(mainpageViewModel.firstCar)
        carList.append(mainpageViewModel.secondCar)
    }
}

//MARK: - Tableview Method
extension Mainpage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        carList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "car", for: indexPath) as! CarTableViewCell
        let choosenCar = carList[indexPath.row]
        cell.brandLabel.text = choosenCar.brand
        cell.carImageView.image = UIImage(named: choosenCar.image)
        cell.modelLabel.text = "Model: \(choosenCar.model)"
        cell.roadLabel.text = "Km: \(choosenCar.road)"
        cell.yearLabel.text = "Yıl: \(choosenCar.year)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCar = carList[indexPath.row]
        
        indicator.isHidden = false
        indicator.startAnimating()
        reportLabel.isHidden = false
        DispatchQueue.main.async {
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.reportLabel.isHidden = true
            self.performSegue(withIdentifier: "detail", sender: self.selectedCar)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let destinationVC = segue.destination as? DetailPage{
                destinationVC.choosenCar = selectedCar
            }
        }
    }
}

