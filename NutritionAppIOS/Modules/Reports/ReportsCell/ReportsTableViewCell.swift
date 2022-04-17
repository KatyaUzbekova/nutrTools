//
//  ReportsTableViewCell.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 11.04.2021.
//

import UIKit

class ReportsTableViewCell: UITableViewCell{

    @IBOutlet var reportsForParticularDay: UICollectionView!
    @IBOutlet weak var dateOfReport: UILabel!
    
    weak var parent: ReportsViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        reportsForParticularDay.delegate = self
        reportsForParticularDay.dataSource = self
    }
    private var reportsForCollectionView: [SingleReport]!
    var reports: [SingleReport]! {
        set {
            reportsForCollectionView = newValue
            reportsForParticularDay.reloadData()
        }
        get {
            reportsForCollectionView
        }
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

extension ReportsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoFoodOneDay", for: indexPath) as! SingleReportCollectionViewCell
            cell.link = reports[indexPath.row].imageURL
            cell.reportComment = reports[indexPath.row].comment
            cell.parent = parent
            return cell
    }
}
