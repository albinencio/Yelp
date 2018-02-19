//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate {
  
  var businesses: [Business]!
  var isMoreDataLoading = false
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorInset = .zero
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 120
    
    let searchBar = UISearchBar()
    searchBar.delegate = self
    searchBar.sizeToFit()
    navigationItem.titleView = searchBar
    
    /* Business.searchWithTerm(term: "Restaurants", completion: { (businesses: [Business]?, error: Error?) -> Void in
      
      self.businesses = businesses
      self.tableView.reloadData()
      if let businesses = businesses {
        for business in businesses {
          print(business.name!)
          print(business.address!)
        }
      }
      
    }) */
    
    Business.searchWithTerm(term: "Restaurants", sort: .distance, categories: ["mediterranean", "italian", "asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
      
      self.businesses = businesses
      self.tableView.reloadData()
      
      for business in businesses {
        print(business.name!)
        print(business.address!)
      }
    }
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    Business.searchWithTerm(term: searchText, completion: { (businesses: [Business]?, error: Error?) -> Void in
      
      self.businesses = businesses
      self.tableView.reloadData()
      if let businesses = businesses {
        for business in businesses {
          print(business.name!)
          print(business.address!)
        }
      }
    })
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if businesses != nil {
      return businesses!.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
    
    cell.business = businesses[indexPath.row]
    
    return cell
  }
  
  /* func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (!isMoreDataLoading) {
      // Calculate the position of one screen length before the bottom of the results
      let scrollViewContentHeight = tableView.contentSize.height
      let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
      
      // When the user has scrolled past the threshold, start requesting
      if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
        isMoreDataLoading = true
        
        loadMoreData()
      }
    }
  }
  
  func loadMoreData() {
    
    // ... Create the NSURLRequest (myRequest) ...
    
    // Configure session so that completion handler is executed on main UI thread
    let session = URLSession(configuration: URLSessionConfiguration.default,
                             delegate:nil,
                             delegateQueue:OperationQueue.main
    )
    let task : URLSessionDataTask = session.dataTask(with: myRequest, completionHandler: { (data, response, error) in
      
      // Update flag
      self.isMoreDataLoading = false
      
      // ... Use the new data to update the data source ...
      
      // Reload the tableView now that there is new data
      self.myTableView.reloadData()
    })
    task.resume()
  } */
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
