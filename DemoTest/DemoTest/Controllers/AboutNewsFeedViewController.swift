//
//  AboutNewsFeedViewController.swift
//  DemoTest
//
//  Created by Mohammad Yunus on 8/9/18.
//  Copyright © 2018 Mohammad Yunus. All rights reserved.
//

import UIKit

class AboutNewsFeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    
    var refreshControl: UIRefreshControl?
    var aboutNewsFeedViewModel : AboutNewsFeedViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the refresh control for the refreshing datas
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(getNewsFeedDetailsFromServer), for: .valueChanged)
        //refreshControl?.bringSubviewToFront(tableView)
        
        aboutNewsFeedViewModel = AboutNewsFeedViewModel()
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.dropShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getNewsFeedDetailsFromServer()
    }
    
    
    @objc func getNewsFeedDetailsFromServer() -> Void {
        aboutNewsFeedViewModel.getAboutNewsFeedData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.title = "NY Times Most Popular"
            }
        }
    }
    
    func dropShadow(scale: Bool = true) {
        navigationView.layer.masksToBounds = false
        navigationView.layer.shadowColor = UIColor.black.cgColor
        navigationView.layer.shadowOpacity = 0.5
        navigationView.layer.shadowOffset = CGSize(width: 0, height: 1)
        navigationView.layer.shadowRadius = 1
        
        var rect = navigationView.bounds
        rect.size.width = UIScreen.main.bounds.size.width
        navigationView.layer.shadowPath = UIBezierPath(rect: rect).cgPath
        navigationView.layer.shouldRasterize = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: Data Source
extension AboutNewsFeedViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutNewsFeedViewModel.numberofRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "demoCell") as! demoCell
        
        let item = aboutNewsFeedViewModel.getNewsFeedRecord(indexPath: indexPath)
        cell.configure(aboutFeed: item)
        
        return cell
    }
}
