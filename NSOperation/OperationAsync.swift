//
//  OperationAsyn.swift
//  NSOperation
//
//  Created by Hiren Patel on 01/10/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class OperationAsync: NSObject {

    let operationQueue = OperationQueue.init()
    var completionOperation : BlockOperation?

    var firstGroupTask: BaseBlockOperation = BaseBlockOperation.init()
    var secondGroupTask: BaseBlockOperation = BaseBlockOperation.init()
    var thirdGroupTask: BaseBlockOperation = BaseBlockOperation.init()
    let baseBlockOperation: BaseBlockOperation = BaseBlockOperation.init()
    var blockOperationTest: BaseBlockOperation?
    var urlSessionTaskOperation: URLSessionTaskOperation?
    var alertOperation: AlertOperation?

    var groupOperation: GroupOperation?
    var operation1: BlockOperation?

    func blockOperationWithAsyncAPI() {
        
        completionOperation =  BlockOperation.init(block: {
            print("Get Response from All API")
        })
        
//        operation1 = BlockOperation.init()
//
//        operation1?.addExecutionBlock {
//            ApiManager.shared.getUserInformation(message: { (message) in
//            })
//        }
        blockOperationTest = BaseBlockOperation.init(block: { (block) in
            ApiManager.shared.getUserInformation(message: { (message) in
                print("============== blockOperationTest is finished ==============")
                block()
            })
        })
        blockOperationTest?.name = "blockOperationTest"

        
        operation1?.completionBlock = {
            print("operation1 is completed")
        }
        
        completionOperation?.addDependency(blockOperationTest!)
        operation1?.name = "operation1"
        completionOperation?.name = "completionOperation"
        SimpleObserver.sharedSimpleObserver.observeOperation(op: blockOperationTest!)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: completionOperation!)

        operationQueue.addOperations([completionOperation!, blockOperationTest!], waitUntilFinished: false)
        operationQueue.isSuspended = false
    }
    


    func operationQueueDepenciesWithAPI(viewController: UIViewController) {
        
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.isSuspended = true
        completionOperation =  BlockOperation.init(block: {
            print("Get Response from All API")
        })
        
        operation1?.addExecutionBlock {
        }
        
        blockOperationTest = BaseBlockOperation.init(block: { (block) in
            ApiManager.shared.getUserInformation(message: { (message) in
                print("============== blockOperationTest is finished ==============")
                block()
            })
        })
        
        firstGroupTask = BaseBlockOperation.init(block: { (block) in
            print(" first is start")
            ApiManager.shared.getUserInformation(message: { (message) in
                print("============== first is finished ==============")
                block()
            })
        })
        
        secondGroupTask.addExecutionBlock {
            self.secondGroupTask.executing(true)
            print(" secondGroupTask is start")
            self.secondGroupTask.finish(true)
            self.secondGroupTask.executing(false)
            
        }
        
        thirdGroupTask = BaseBlockOperation.init(block: { (block) in
            print(" third is start")
            ApiManager.shared.getAllPosts(message: { (message) in
                print("============== third task is finished ==============")
                block()
            })
        })
        
        completionOperation?.addDependency(firstGroupTask)
        completionOperation?.addDependency(secondGroupTask)
        completionOperation?.addDependency(thirdGroupTask)
        firstGroupTask.name = "firstGroupTask"
        secondGroupTask.name = "secondGroupTask"
        thirdGroupTask.name = "thirdGroupTask"
        completionOperation?.name = "completionOperation"
        SimpleObserver.sharedSimpleObserver.observeOperation(op: firstGroupTask)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: secondGroupTask)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: thirdGroupTask)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: completionOperation!)
        
        operationQueue.addOperations([blockOperationTest!, firstGroupTask, secondGroupTask, thirdGroupTask ,completionOperation!], waitUntilFinished: false)
        operationQueue.isSuspended = false
    }
    
    
    func operationWithGroupOperations(viewController: UIViewController) {
        
        urlSessionTaskOperation = URLSessionTaskOperation.init()
        alertOperation = AlertOperation.init(presentationContext: viewController)
        urlSessionTaskOperation?.name = "URLSessionTaskOperation"
        alertOperation?.name = "AlertOperation"
        alertOperation?.title = "Info"
        alertOperation?.message = "All file is downloded"
        alertOperation?.addDependency(urlSessionTaskOperation!)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: urlSessionTaskOperation!)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: alertOperation!)
        groupOperation = GroupOperation.init(operations: [urlSessionTaskOperation!, alertOperation!])
    }
    
}
