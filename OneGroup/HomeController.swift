//
//  HomeController.swift
//  OneGroup
//
//  Created by Developer on 01/08/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet var homeTableView: UITableView!
    var dataArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - UITableViewDataSource

extension HomeController: UITableViewDataSource {
    func maxItemOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeCell.dequeue(tableView, indexPath)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


class HomeCell: UITableViewCell {
    class func dequeue (_ tableView: UITableView, _ indexPath: IndexPath) -> HomeCell {
        return tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
    }
    var title: String = "" {
        didSet {
            update ()
        }
    }

    private func update() {
        
    }
}
