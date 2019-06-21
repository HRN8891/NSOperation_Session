//
//  ViewController.swift
//  NSOperation
//
//  Created by Hiren Patel on 08/06/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class UserManager: NSObject {
    
    let user: User = User()
    let userId: NSNumber = 2
    
    static let instance: UserManager = UserManager()
    class var shared: UserManager {
        return instance
    }
}
typealias message = (_ messageString : String?) -> ()


class ViewController: UIViewController {

    let userManager: UserManager = UserManager.shared

    let simpleObserver: SimpleObserver = SimpleObserver()
    let operationQueue = OperationQueue.init()
    var completionOperation : BlockOperation?
    var operation1: BlockOperation?
    var operation2: BlockOperation?
    var operation3: BlockOperation?

    var firstGroupTask: BaseBlockOperation = BaseBlockOperation.init()
    var secondGroupTask: BaseBlockOperation = BaseBlockOperation.init()
    var thirdGroupTask: BaseBlockOperation = BaseBlockOperation.init()
    let baseBlockOperation: BaseBlockOperation = BaseBlockOperation.init()
    var blockOperationTest: BaseBlockOperation?
    let operationAsync = OperationAsync()
    let operationDependency = OperationDependency()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let blockOperationSample = BlockOperationSample()
////        blockOperationSample.blockOperation()
//        blockOperationSample.blockOperationAddmultipleOperations()
        
//        let operationQueuePriority = OperationQueuePriority()
//        operationQueuePriority.operationBasicUnderstanding()
////        operationQueuePriority.operatioWaitUntilFinished()
        
//        operationDependency.operationDependancyForOtherQueue()
        operationAsync.operationWithGroupOperations(viewController: self)
        
//        operationAsync.operationQueueDepenciesWithAPI(viewController: self)
//        operationAsync.operationWithGroupOperations(viewController: self)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
}


class SimpleObserver: NSObject {
    
    static let sharedSimpleObserver = SimpleObserver()
    
    class func shared() -> SimpleObserver {
        return sharedSimpleObserver
    }
    func observeOperation(op: Operation) {
        op.addObserver(self, forKeyPath: "executing", options: .new, context: nil)
        op.addObserver(self, forKeyPath: "cancelled", options: .new, context: nil)
        op.addObserver(self, forKeyPath: "finished", options: .new, context: nil)
        op.addObserver(self, forKeyPath: "concurrent", options: .initial, context: nil)
        op.addObserver(self, forKeyPath: "asynchronous", options: .initial, context: nil)
        op.addObserver(self, forKeyPath: "ready", options: .initial, context: nil)
        op.addObserver(self, forKeyPath: "name", options: .initial, context: nil)
    }
    
    func observeQueue(queue: OperationQueue) {
        queue.addObserver(self, forKeyPath: "operations", options: .new, context: nil)
        queue.addObserver(self, forKeyPath: "operationCount", options: .new, context: nil)
        queue.addObserver(self, forKeyPath: "maxConcurrentOperationCount", options: .new, context: nil)
        queue.addObserver(self, forKeyPath: "suspended", options: .new, context: nil)
        queue.addObserver(self, forKeyPath: "name", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let key = keyPath!
        switch key {
        case "cancelled", "finished", "concurrent", "asynchronous", "ready", "name":
            if let operation = object as? Operation {
                print("\(String(describing: operation.name)) is \(key) = \(String(describing: operation.value(forKey: key)))")
            }
        case "executing":
            if let operation = object as? Operation {
                print("\(String(describing: operation.name)) is \(key) = \(String(describing: operation.value(forKey: key)))")
            }
        case "operations", "operationCount", "maxConcurrentOperationCount", "suspended", "name":
            if let operationQueue = object as? OperationQueue {
                print("operationQueue \(key) = \(String(describing: operationQueue.value(forKey: key)))")
            }
        default:
            return
        }
    }

}


class User: NSObject {
    
    var name: String?
    var email: String?
    var address: String?
    var username: String?
    var phone: String?
    var posts: [Post] = []
    
    override init() {
        
    }
    func configureUserDetail(userDetail: [String: AnyObject]) {
        self.name = userDetail["name"] as? String
        self.email = userDetail["email"] as? String
        self.address = userDetail["address"] as? String
        self.username = userDetail["username"] as? String
        self.phone = userDetail["phone"] as? String
    }
    override  var description: String  {
        var description = ""
        description += "name is \(self.name ?? "")\n"
        description += "email is \(self.email ?? "")\n"
        description += "address is \(self.address ?? "")\n"
        description += "username is \(self.username ?? "")\n"
        description += "phone is \(self.phone ?? "")\n"
        return description
    }
    
    
}


class Post: NSObject {
    
    var userId: String?
    var title: String?
    var id: String?
    
    override init() {
        
    }
    func configurePost(postDetail: [String: AnyObject]) {
        self.userId = postDetail["userId"] as? String
        self.title = postDetail["title"] as? String
        self.id = postDetail["id"] as? String
    }
}
class ApiManager: NSObject {
    
    static let instance: ApiManager = ApiManager()
    class var shared: ApiManager {
        return instance
    }
    
    
    func searchWithResult(searchText: String, completion:@escaping (_ brands: [String: AnyObject]?, _ error: Error?) -> ()) {
        
        let url : String = "https://trackapi.nutritionix.com/v2/search/instant?query=\(searchText)"
        print("Request : \(url)")
        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        var request = URLRequest(url: URL.init(string: escapedString)!)
        request.httpMethod = "GET"
        request.setValue("ef928818", forHTTPHeaderField: "x-app-id")
        request.setValue("15354dd7a87bd29233fd8af834a83bf1", forHTTPHeaderField: "x-app-key")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if response != nil {
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion((json as! [String : AnyObject]), nil)
                }catch {
                    completion(nil, error)
                }
            }
            }.resume()
    }
    
    
    
    func getUserInformationForUserId(userID: String, completion:@escaping (_ user: User?, _ error: Error?) -> ()) {
        let url = URL(string: "http://jsonplaceholder.typicode.com/users/\(userID)")
        let session = URLSession.shared
        if let usableUrl = url {
            let task = session.dataTask(with: usableUrl, completionHandler: { (data, response, error) in
                if let data = data {
                    do {
                        let decoded = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictFromJSON = decoded as? [String:AnyObject] {
                            let user: User = User()
                            user.configureUserDetail(userDetail: dictFromJSON)
                            completion(user, nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            })
            task.resume()
        }
    }
    
    
    func getUserInformation(message: @escaping message) {
        let url = URL(string: "http://jsonplaceholder.typicode.com/users/\(UserManager.shared.userId)")
        let session = URLSession.shared
        if let usableUrl = url {
            let task = session.dataTask(with: usableUrl, completionHandler: { (data, response, error) in
                if let data = data {
                    do {
                        let decoded = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictFromJSON = decoded as? [String:AnyObject] {
                            UserManager.shared.user.configureUserDetail(userDetail: dictFromJSON)
                            print(dictFromJSON)
                            message("test")
                        }
                    } catch {
                        message("test")
                        print(error.localizedDescription)
                    }
                }
            })
            task.resume()
        }
    }
    
    
     func getAllPosts(message: @escaping message) {
        let postUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let postUrlsession = URLSession.shared
        if let postUrlsessionUsableUrl = postUrl {
            let task = postUrlsession.dataTask(with: postUrlsessionUsableUrl, completionHandler: { (data, response, error) in
                if let data = data {
                    do {
                        let decoded = try JSONSerialization.jsonObject(with: data, options: [])
                        if let allPosts = decoded as? [[String:AnyObject]] {
                            let userPosts:[[String:AnyObject]] = allPosts.filter{($0["userId"] as! NSNumber) == UserManager.shared.userId}
                            
                            if userPosts.count > 0 {
                                var posts: [Post] = []
                                for userPost in userPosts {
                                    let post: Post = Post()
                                    post.configurePost(postDetail: userPost)
                                    posts.append(post)
                                }
                                UserManager.shared.user.posts = posts
                                print(decoded)
                                message("test")
                            }
                        }
                    } catch {
                        message("test")
                        print(error.localizedDescription)
                    }
                }
            })
            task.resume()
        }
    }
}

//        operationQueue.maxConcurrentOperationCount = 1
//        let operation = BlockOperation { [weak self] in
//            let operationSecond = BlockOperation {
//                print("operationSecond")
//            }
//            self?.operationQueue.addOperation(operationSecond)
//            print("operationFirst")
//            sleep(2)
//        }
//        operationQueue.addOperation(operation)
//
//        return
//
//        for i in 1...10 {
//            let apiOperation : BlockOperation = BlockOperation.init(block: {
//                print("Fetch Response for \(i)")
//                sleep(2)
//                print("Get Response from \(i)")
//            })
//            apiOperation.name = "Operation \(i)"
//            completionOperation?.addDependency(apiOperation)
//            operationQueue.addOperation(apiOperation)
//            simpleObserver.observeOperation(op: apiOperation)
//        }
//        print("Added all Task to Queue")
//        operationQueue.addOperation(completionOperation!)
//        operationQueue.isSuspended = false
//        sleep(5)
//        operationQueue.cancelAllOperations()
