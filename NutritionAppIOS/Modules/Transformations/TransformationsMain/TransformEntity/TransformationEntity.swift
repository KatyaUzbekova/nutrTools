//
//  TransformationEntity.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 28.05.2021.
//

import UIKit

class TransformationEntity: UITableViewCell{

    @IBOutlet var transformationsForParticularDay: UICollectionView!
    @IBOutlet weak var dateOfSubmission: UILabel!
    var comments: String!
    weak var parent: TransformationsMainViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        transformationsForParticularDay.delegate = self
        transformationsForParticularDay.dataSource = self
    }
    private var reportsForCollectionView: [String]!
    var transformations: [String]! {
        set {
            reportsForCollectionView = newValue
            transformationsForParticularDay.reloadData()
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

extension TransformationEntity: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        transformations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoForTransformation", for: indexPath) as! SingleTransformationCollectionViewCell
        cell.parent = parent
        cell.link = transformations[indexPath.row]
        cell.reportComment = comments
        return cell
    }
}
