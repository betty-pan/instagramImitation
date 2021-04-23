//
//  PostsTableViewController.swift
//  instagramImitation
//
//  Created by Betty Pan on 2021/4/22.
//

import UIKit

class PostsTableViewController: UITableViewController {
    @IBOutlet weak var userAcountLabel: UILabel!
    
    //貼文資訊
    let postInfo:InstagramResponse.Graphql.User.Edge_owner_to_timeline_media
    let indexPath:Int
    let userImageUrl:URL
    let userAcount:String
    
    init?(coder:NSCoder,userInfo:InstagramResponse, indexPath:Int ) {
        self.postInfo = userInfo.graphql.user.edge_owner_to_timeline_media
        self.indexPath = indexPath
        self.userImageUrl = userInfo.graphql.user.profile_pic_url
        self.userAcount = userInfo.graphql.user.username
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    var isShow = false
    override func viewDidLayoutSubviews() {
        if isShow == false{
            tableView.scrollToRow(at: IndexPath(item: indexPath, section: 0), at: .top, animated: true)
            isShow = true
            
        }
    }
    
    @IBAction func backToMainScene(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postInfo.edges.count
    }

    //cell's content
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PostDetailTableViewCell.self)", for: indexPath) as? PostDetailTableViewCell else { return UITableViewCell()}
        
        //fetch userImage
        URLSession.shared.dataTask(with: userImageUrl) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    cell.userImageView.layer.cornerRadius = cell.userImageView.frame.width/2
                    cell.userImageView.image = UIImage(data: data)
                    
                }
            }
        }.resume()
        
        //fetch PostImage ( specific [indexPath.row] )
        URLSession.shared.dataTask(with: postInfo.edges[indexPath.row].node.display_url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    cell.postImageView.image = UIImage(data: data)
                    
                }
            }
        }.resume()
        
        // Configure the cell...
        userAcountLabel.text = userAcount
        cell.userAcountLabel.text = userAcount
        cell.postTextView?.text = postInfo.edges[indexPath.row].node.edge_media_to_caption.edges[0].node.text
        cell.likedCountLabel.text = "Liked by Betty and \(postInfo.edges[indexPath.row].node.edge_liked_by.count) others."
        cell.commentCountLabel.text = "View all \(postInfo.edges[indexPath.row].node.edge_media_to_comment.count) comments."
        cell.timeLabel.text = dateFormate(date: postInfo.edges[indexPath.row].node.taken_at_timestamp)
        
        return cell
    }
    
    //日期時間轉換
    func dateFormate(date:Date)->String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        let dateString = formatter.string(from: date)
        
        return dateString
    }
    
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
