//
//  InstagramCollectionViewController.swift
//  instagramImitation
//
//  Created by Betty Pan on 2021/4/20.
//

import UIKit

private let reuseIdentifier = "\(ImageCollectionViewCell.self)"

class InstagramCollectionViewController: UICollectionViewController {
    var userInfo:InstagramResponse?
    var postImages = [InstagramResponse.Graphql.User.Edge_owner_to_timeline_media.Edges]()
    
    
    func fetchData() {
        let urlStr = "https://www.instagram.com/luckylulu0212/?__a=1"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                
                if let data = data {
                    do {
                        let searchResponse = try decoder.decode(InstagramResponse.self, from: data)
                        self.userInfo = searchResponse
                        DispatchQueue.main.async {
                            self.postImages = (self.userInfo?.graphql.user.edge_owner_to_timeline_media.edges)!
                            self.collectionView.reloadData()
                           
                        }
                    } catch {
                        print(error)
                    }
                    
                }
            }.resume()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    @IBSegueAction func showPostDetail(_ coder: NSCoder) -> PostsTableViewController? {
        guard let row = collectionView.indexPathsForSelectedItems?.first?.row else { return nil }
        return PostsTableViewController(coder: coder, userInfo: userInfo!, indexPath: row)
    }
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return postImages.count
    }
    
    //posts cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {return UICollectionViewCell()}
        
        let item = postImages[indexPath.item]
        //fetch Images (PhotoWall)
        URLSession.shared.dataTask(with: item.node.display_url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    cell.showImageView.image = UIImage(data: data)
                }
            }
        }.resume()
        
        // Configure the cell
    
        return cell
    }
    
    //userInfo reusableView
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //ReusableView的ofKind設定為Header, ID對象是userInfo的reusableView, as轉型為自訂reusableView型別
        guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(UserInfoCollectionReusableView.self)", for: indexPath) as? UserInfoCollectionReusableView else { return UICollectionReusableView() }
        
        //fetch UserInfo
        if let userImageUrl = userInfo?.graphql.user.profile_pic_url {
            URLSession.shared.dataTask(with: userImageUrl) { data, response, error in
                if let data = data {
                    do {
                        DispatchQueue.main.async {
                            reusableView.userImageView.layer.cornerRadius = reusableView.userImageView.frame.width/2
                            reusableView.userImageView.image = UIImage(data: data)
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
        //代入欲顯示資料之對應元件
        if let postCount = userInfo?.graphql.user.edge_owner_to_timeline_media.count,
           let followersCount = userInfo?.graphql.user.edge_followed_by.count,
           let followingCount = userInfo?.graphql.user.edge_follow.count,
           let userName = userInfo?.graphql.user.full_name,
           let userAcount = userInfo?.graphql.user.username,
           let category = userInfo?.graphql.user.category_name,
           let bio = userInfo?.graphql.user.biography {
            
            reusableView.postCountLabel.text = String(postCount)
            reusableView.followerCountLabel.text = String(followersCount)
            reusableView.followingCountLabel.text = String(followingCount)
            reusableView.userNameLabel.text = userName
            reusableView.userAcountLabel.text = userAcount
            reusableView.categoryLabel.text = category
            reusableView.userDescriptionLabel.text = bio
            
            for i in reusableView.btns {
                i.layer.borderWidth = 1
                i.layer.cornerRadius = 3
                i.layer.borderColor = UIColor(red: 218/255, green: 219/255, blue: 218/255, alpha: 1).cgColor
            }
            
        }
        
        return reusableView
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
