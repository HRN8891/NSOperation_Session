//
//  OperationQueuePriority.swift
//  NSOperation
//
//  Created by Hiren Patel on 30/09/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class OperationQueuePriority: NSObject {

    let operationQueue = OperationQueue.init()
    var completionOperation : BlockOperation?
    var operation1: BlockOperation?
    var operation2: BlockOperation?
    var operation3: BlockOperation?
    let operationQueueSecond = OperationQueue.init()
    
    func operationBasicUnderstanding() {
        self.operationQueue.maxConcurrentOperationCount = 2
//        self.operationQueue.isSuspended = true
        
        operation1 = BlockOperation {
            for i in 10...200 {
                if self.operation1?.isCancelled == true {
                    break
                }
                print("🔷", i)
                
            }
        }
        
        
        operation1?.completionBlock = {
            print("Finish operation1")
        }
        
        operation2 = BlockOperation {
            for i in 1000..<1010 {
                if self.operation2?.isCancelled == true {
                    break
                }
                print("⚪️⚫️", i)
            }
            
        }
        
        operation2?.completionBlock = {
            print("Finish operation2")
        }
        
        
        operation3 = BlockOperation {
        }
        
        operation3?.addExecutionBlock {
            for i in 200..<300 {
                if self.operation3?.isCancelled == true {
                    break
                }
                print("⚪️", i)
            }
        }
        
        operation3?.completionBlock = {
            print("Finish operation3")
        }
        
       
        operation1?.queuePriority = .veryLow
        operation2?.queuePriority = .veryHigh
        operation3?.queuePriority = .veryHigh
        
        operation3?.name = "operation3"
        operation1?.name = "operation1"
        operation2?.name = "operation2"
        
        SimpleObserver.sharedSimpleObserver.observeOperation(op: operation1!)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: operation2!)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: operation3!)
        
        self.operationQueue.addOperations([operation1!, operation2!, operation3!], waitUntilFinished: false)
        sleep(UInt32(0.5))
//        operation2?.cancel()
//       self.operationQueue.cancelAllOperations()
//        self.operationQueue.isSuspended = false
    }
    
    
    func operatioWaitUntilFinished() {
        
        self.operationQueue.maxConcurrentOperationCount = 1
        operation1 = BlockOperation {
            for i in 10...200 {
                print("🔷", i)
                
            }
        }
        
        operation1?.completionBlock = {
            print("Finish operation1")
        }
        
        operation2 = BlockOperation {
            for i in 1000..<1010 {
                print("⚪️⚫️", i)
            }
            
        }
        
        operation2?.completionBlock = {
            print("Finish operation2")
        }
        
        
        operation3 = BlockOperation {
        }
        
        operation3?.addExecutionBlock {
            print("Waitting for finished all operation of the operationQueue queue")
            self.operationQueue.waitUntilAllOperationsAreFinished()
            print("executting for operation3")
            for i in 200..<300 {
                print("⚪️", i)
            }
        }
        
        operation3?.completionBlock = {
            print("Finish operation3")
        }
        
        operation3?.name = "operation3"
        operation1?.name = "operation1"
        operation2?.name = "operation2"
        SimpleObserver.sharedSimpleObserver.observeQueue(queue: self.operationQueue)

        self.operationQueue.addOperations([operation1!, operation2!], waitUntilFinished: false)
        self.operationQueueSecond.addOperation(operation3!)
    }
    
}
