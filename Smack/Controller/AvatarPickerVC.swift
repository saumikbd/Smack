//
//  AvaterPickerVC.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/25/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentValue: UISegmentedControl!
   
    var avaterType: AvatarType = .dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func segmentValueChanged(_ sender: Any) {
        switch segmentValue.selectedSegmentIndex {
        case 0:
            avaterType = .dark
            print("DARK\n")
        case 1:
            avaterType = .light
            print("LIGHT\n")
        default:
            avaterType = .dark
            print("dark\n")
        }
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as? AvatarCell {
            cell.updateView(index: indexPath.row, avatarType: self.avaterType)
            return cell
        }
        return AvatarCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avaterType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.row)")
        }
        else{
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.row)")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColoumns:CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numberOfColoumns = 4
        }
        let spaceBetweenCells:CGFloat = 10
        let dimention = (collectionView.bounds.width - (numberOfColoumns - 1) * spaceBetweenCells) / numberOfColoumns
        return CGSize(width: dimention, height: dimention)
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
