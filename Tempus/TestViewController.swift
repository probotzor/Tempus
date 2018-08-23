//
//  TestViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/28/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit

class TestViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.myLabel.text = "ABCD"
        return cell;
    }
    
    
    @IBOutlet weak var collection: UICollectionView!
   

    @IBOutlet weak var celija: UICollectionView!
    

}
