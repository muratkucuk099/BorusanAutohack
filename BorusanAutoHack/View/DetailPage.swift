//
//  DetailPage.swift
//  BorusanAutoHack
//
//  Created by Mac on 14.12.2023.
//

import UIKit

class DetailPage: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    var choosenCar: Car? = nil
    let openAICall = OpenAIAPIModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
        if let car = choosenCar {
            imageview.image = UIImage(named: car.image)
            modelLabel.text = "\(car.brand) \(car.model)"
            descriptionLabel.text = openAICall.processPrompt(prompt: "\(car.brand) \(car.model) \(car.year) model aracın ortalama g kuvveti verilerini sana göndererek aracın ne kadar sert kullanıldığını raporlamanı istiyorum. Aracın ortalama yanal g kuvveti değeri \(car.xg), ileri-geri ortalama g kuvveti, \(car.yg), ve yukarı-aşağı(dikey) g kuvveti ortalama \(car.zg). Bu verilere göre kısa profesyonel bir açıklama yapar mısın. Açıklamanın yanında bu arabanın 2. el değeri ve sigorta/kasko değeri hakkında fiyat vermeden genel bilgilendirme yapar mısın?")
            
        }
    }
    
}
