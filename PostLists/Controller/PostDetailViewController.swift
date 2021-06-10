//
//  PostDetailViewController.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//

import UIKit
class PostDetailViewController: UIViewController {
    
    
    @IBOutlet weak var postsDetailTableView: UITableView!
    private var postsDetailViewModel : PostDetailViewModel!
    var postDetail: Posts!
    
    private var dataSource : PostsDetailTableViewDatasource<PostsTableViewCell,Comments>!
    private var delegate : PostDetailTableViewDelegate<PostsTableViewCell>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.postsDetailViewModel =  PostDetailViewModel(postId: postDetail.id, postDetail: postDetail)
        self.postsDetailViewModel.bindPostsDetailViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        self.dataSource = PostsDetailTableViewDatasource (cellIdentifier: "PostsTableViewCell", items: self.postsDetailViewModel.postDetailData, configureCell: { (cell, cmt, celltype) in
            //SetUp Labels
            cell.postsIdLabel.textColor = UIColor.black
            cell.postsTextLabel.textColor = UIColor.darkGray
            cell.postsTextLabel.textAlignment = .left
            cell.postsIdLabel.font = UIFont.systemFont(ofSize: 20.0)
            if celltype == .Title{
                cell.postsIdLabel?.text = "Title"
                cell.postsTextLabel?.text = self.postDetail?.title ?? "N/A"
            }else if celltype == .Description{
                cell.postsIdLabel?.text = "Description"
                cell.postsTextLabel?.text = self.postDetail?.body ?? "N/A"
            }else if celltype == .UserDetail{
                cell.postsIdLabel?.text = "User Detail"
                fetchUserAddress(userID: self.postDetail?.userId ?? 0) { (address) in
                    let strAddress = "\(address.suite ?? "") \(address.street ?? "") \(address.city ?? "")-\(address.zipcode ?? "")"
                    cell.postsTextLabel?.text = "Name: \(self.postsDetailViewModel.users?.name ?? "N/A")\nEmail: \(self.postsDetailViewModel.users?.email ?? "N/A")\nPhone: \(self.postsDetailViewModel.users?.phone ?? "N/A")\nAddress: \(strAddress)"
                }
            }else if celltype == .CommentTitle{
                cell.postsIdLabel?.text = "Comments(\(self.postsDetailViewModel.postDetailData.count))"
                cell.postsTextLabel?.text = ""
            }else{
                cell.postsIdLabel?.text = "\(cmt?.body ?? "N/A")"
                cell.postsTextLabel.text = "Commented By: \(cmt?.email ?? "")"
                cell.postsIdLabel.textColor = UIColor.darkGray
                cell.postsTextLabel.textColor = UIColor.black
                cell.postsTextLabel.textAlignment = .right
                cell.postsIdLabel.font = UIFont.systemFont(ofSize: 17.0)
            }
        })
        
        self.delegate = PostDetailTableViewDelegate(cellIdentifier: "PostsTableViewCell")
        
        DispatchQueue.main.async {
            self.postsDetailTableView.dataSource = self.dataSource
            self.postsDetailTableView.delegate = self.delegate
            self.postsDetailTableView.reloadData()
        }
    }
}

