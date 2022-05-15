//
//  FeedApi.swift
//  ShoppingCart
//
//  Created by George Nhari on 16/4/2022.
//

//import FirebaseDatabase
//import RealmSwift
//
//class FeedApi {
//
//    let dict_timestamp = "timestamp"
//    var homeFeed = Config.DATABASE_MAIN.child("feed")
//
//    func fetchRecentHomeFeed(latestTimestamp timestamp: Int? = nil, completion: @escaping () -> Void, onFailure: @escaping () -> Void) {
//
//        let file = homePostsOnDisk!
//
//        guard let uid =  Api.User.CURRENT_USER?.uid else { return }
//        let feedQuery = query(uid: uid, REF_FEED: homeFeed, latestTimestamp: timestamp)
//
//        observeFeedFromDatabase(feedQuery: feedQuery, forLocalChild: uid, file: file) {
//            completion()
//        } onFailure: {
//            onFailure()
//        }
//    }
//
//    func fetchOlderHomeFeed(oldestTimestamp timestamp: Int? = nil, completion: @escaping () -> Void, onFailure: @escaping () -> Void) {
//
//        let file = homePostsOnDisk!
//        guard let uid =  Api.User.CURRENT_USER?.uid else { return }
//        let feedQuery = query(uid: uid, REF_FEED: homeFeed, oldestTimestamp: timestamp)
//
//        observeFeedFromDatabase(feedQuery: feedQuery, forLocalChild: uid, file: file, deleteOlder: false) {
//            completion()
//        } onFailure: {
//            onFailure()
//        }
//    }
//
//    /// set query
//    /// - Parameters:
//    ///   - uid: <#uid description#>
//    ///   - REF_FEED: <#REF_FEED description#>
//    ///   - latestTimestamp: <#latestTimestamp description#>
//    ///   - oldestTimestamp: <#oldestTimestamp description#>
//    ///   - limit: <#limit description#>
//    /// - Returns: <#description#>
//    func query(uid: String, REF_FEED: DatabaseReference, latestTimestamp: Int? = nil, oldestTimestamp: Int? = nil, limit: UInt = 10) -> DatabaseQuery {
//
//        var feedQuery = REF_FEED.child(uid).queryOrdered(byChild: dict_timestamp)
//
//        if let latestPostTimestamp = latestTimestamp, latestPostTimestamp > 0 {
//            // query feed before the latest post
//            feedQuery = feedQuery.queryStarting(atValue: latestPostTimestamp + 1, childKey: dict_timestamp).queryLimited(toLast: limit)
//
//        } else if let oldestTimestamp = oldestTimestamp {
//            // query feed after the oldest post
//            feedQuery = feedQuery.queryEnding(atValue: oldestTimestamp - 1, childKey: dict_timestamp).queryLimited(toLast: limit)
//
//        } else {
//            // else just query
//            feedQuery = feedQuery.queryLimited(toLast: limit)
//        }
//
//        return feedQuery
//    }
//
//    /// get posts
//    /// - Parameters:
//    ///   - feedQuery: custom filtered query
//    ///   - child: localdatabase filter predicate
//    ///   - file: file to write to
//    ///   - deleteOlder: should older posts in local database be deleted
//    ///   - completion: success
//    ///   - onFailure: failure
//    func observeFeedFromDatabase(feedQuery: DatabaseQuery, forLocalChild child: String, file: Realm, deleteOlder: Bool = true,
//                                 completion: @escaping () -> Void, onFailure: @escaping () -> Void) {
//
//        feedQuery.observeSingleEvent(of: .value) { (snapshot) in
//
//            if snapshot.exists() { // if feed exists
//
//                guard let items = (snapshot.children.allObjects as? [DataSnapshot]) else {
//
//                    onFailure()
//                    return
//                }
//
//                    items.forEach { (item) in
//
////                        Api.Post.observePost(withId: item.key) { (post) in
////
//////                            RealmPost.writePost(post, toFile: file, deleteOlder: deleteOlder, localChild: child)
////
////                        } onFailure: {
////                            // TO-DO: Should write an empty post
////                            onFailure()
////                        }
//                    }
//                completion()
//
//            } else {
//
//                onFailure()
//            }
//        }
//    }
//}
