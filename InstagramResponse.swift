//
//  InstagramResponse.swift
//  instagramImitation
//
//  Created by Betty Pan on 2021/4/20.
//

import Foundation

struct InstagramResponse:Decodable {
    let graphql:Graphql
    struct Graphql:Decodable {
        let user:User
        //使用者資訊
        struct User:Decodable {
            let full_name:String //名字
            let category_name:String //帳號分類類別名稱
            let biography:String //自介
            let edge_follow:Edge_follow //追蹤人數
            struct Edge_follow:Decodable {
                let count:Int
            }
            let edge_followed_by:Edge_followed_by //被追蹤人數
            struct Edge_followed_by:Decodable {
                let count:Int
            }
            let profile_pic_url:URL //使用者頭貼
            let username:String //帳號
            let edge_owner_to_timeline_media:Edge_owner_to_timeline_media //貼文
            //貼文資訊
            struct Edge_owner_to_timeline_media:Decodable {
                let count:Int //總貼文數
                let edges:[Edges]
                struct Edges:Decodable {
                    let node:Node
                    struct Node:Decodable{
                        let display_url:URL //貼文圖片url
                        let edge_media_to_caption:Edge_media_to_caption //貼文文字
                        struct Edge_media_to_caption:Decodable {
                            let edges:[Edges]
                            struct Edges:Decodable {
                                let node:Node
                                struct Node:Decodable {
                                    let text:String
                                }
                            }
                        }
                        let edge_media_to_comment:Edge_media_to_comment //留言數量
                        struct Edge_media_to_comment:Decodable {
                            let count:Int
                        }
                        let edge_liked_by:Edge_liked_by //貼文按讚數
                        struct Edge_liked_by:Decodable {
                            let count:Int
                        }
                    }
                }
            }
        }
    }
}












