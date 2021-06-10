//
//  PostsListingViewController.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//

import UIKit

class PostsListingViewController: UIViewController {
    
    
    @IBOutlet weak var postsTableView: UITableView!
    
    private var postsViewModel : PostsViewModel!
    
    private var dataSource : PostsTableViewDataSource<PostsTableViewCell,Posts>!
    private var delegate : PostsTableViewDelegate<PostsTableViewCell,Posts>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.postsViewModel =  PostsViewModel()
        self.postsViewModel.bindPostsViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = PostsTableViewDataSource(cellIdentifier: "PostsTableViewCell", items: self.postsViewModel.postData, configureCell: { (cell, evm) in
            cell.postsIdLabel.text = evm.title
            cell.postsTextLabel.text = evm.body
        })
        
        self.delegate = PostsTableViewDelegate(cellIdentifier: "PostsTableViewCell", items: self.postsViewModel.postData, configureCell: { (cell, evm) in

        })
        
        DispatchQueue.main.async {
            self.postsTableView.dataSource = self.dataSource
            self.postsTableView.delegate = self.delegate
            self.postsTableView.reloadData()
        }
    }
    
}

