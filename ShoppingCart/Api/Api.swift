//
//  Api.swift
//  ShoppingCart
//
//  Created by George Nhari on 16/4/2022.
//

import FirebaseDatabase

struct Api {
    // All api instances
    static var User = UserApi()
    static let Auth = AuthService.self
//    static var Post = PostApi()
//    static var Comment = CommentApi()
//    static var MyPosts = MyPostsApi()
//    static var Follow = FollowApi()
//    static var Feed = FeedApi()
//    static var Notification = NotificationApi()
//    static var Space = SpaceApi()
//    static var Questions = QuestionApi()
//    static var MyQuestions = MyQuestionsApi()
//    static var MyAnswers = MyAnswersApi()
//    static var Answers = AnswersApi()
//    static var ColorScheme = ColorSchemeApi()
//    static var Realm = RealmApi()
//    static var Report = ReportApi()
//    static var Block = BlockApi()
//    static var Tags = TagsApi()
}

struct Config {
    
    static var REF_USERS = Config.DATABASE_MAIN.child("users")
//    static var REF_USER_INFO = Config.DATABASE_MAIN.child("us")
    static var DATABASE_MAIN: DatabaseReference {
        
//        #if DEBUG
//
//        return Database.database(url: "https://quicktake-6d3b2-default-rtdb.firebaseio.com/").reference() // database to use when in debug mode
//        #else
//
//        return Database.database(url: "https://velocityshopping.firebaseio.com/").reference() // database to use when in release mode
//        #endif
        
        return Database.database().reference()
    }
}
