//
//  ReportsTableViewCell.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 09.04.2021.
//

import UIKit

class MeasurementsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reportsNumber: UILabel!
    @IBOutlet weak var reportsDate: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var taliaLabel: UILabel!
    @IBOutlet weak var hipLabel: UILabel!
    @IBOutlet weak var neckLabel: UILabel!
    @IBOutlet weak var chestLabel: UILabel!
    @IBOutlet weak var golenLabel: UILabel!
    
    
    func removeNullsFromString(_ string: Double) -> String{
        return "\(Float("\(string)")!.clean)"
    }
    var reportsCellData: SingleMeasurement! {
        didSet {
            reportsNumber.text = NSLocalizedString("MeasurementsTableViewCell.MeasurementsNumber", comment: "Measurements number")
            reportsDate.text = reportsCellData.date
            weightLabel.text = removeNullsFromString(reportsCellData.weight)
            taliaLabel.text = removeNullsFromString(reportsCellData.waist)
            hipLabel.text = removeNullsFromString(reportsCellData.hip)
            neckLabel.text = removeNullsFromString(reportsCellData.neck)
            chestLabel.text = removeNullsFromString(reportsCellData.chest)
            golenLabel.text = removeNullsFromString(reportsCellData.calve)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
