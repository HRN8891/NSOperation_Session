//
//  GroupOperation.swift
//  NSOperation
//
//  Created by Hiren Patel on 01/10/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class GroupOperation: NSObject {

    private let internalQueue = OperationQueue()
    private let startingOperation = BlockOperation(block: {})
    private let finishingOperation = BlockOperation(block: {})
    
    convenience init(operations: Operation...) {
        self.init(operations: operations)
    }
    
    init(operations: [Operation]) {
        super.init()
        
        internalQueue.isSuspended = true
        internalQueue.maxConcurrentOperationCount = 1
        
        startingOperation.completionBlock = {
            print("Group Operation is started")
        }
        internalQueue.addOperation(startingOperation)
        for operation in operations {
            finishingOperation.addDependency(operation)
            internalQueue.addOperation(operation)
        }
        self.addStartingOpertaion()
        internalQueue.isSuspended = false
    }
    
     func cancel() {
        internalQueue.cancelAllOperations()
    }
    
     func addStartingOpertaion() {
        finishingOperation.completionBlock = {
            print("Group Operation is finished")
        }
        internalQueue.addOperation(finishingOperation)
    }
    
    func addOperation(operation: Operation) {
        internalQueue.addOperation(operation)
    }

    
}
