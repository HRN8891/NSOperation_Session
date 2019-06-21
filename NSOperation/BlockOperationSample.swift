//
//  BlockOperation.swift
//  NSOperation
//
//  Created by Hiren Patel on 30/09/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class BlockOperationSample: NSObject {
    let operationQueue = OperationQueue.init()
    
    func blockOperation() {
        
        operationQueue.maxConcurrentOperationCount = 2

        let operation = BlockOperation {
            
        }
        
        operation.addExecutionBlock {
            for i in 200..<300 {
                print("⚪️", i)
            }
        }
        
        operation.completionBlock = {
            print("Finish operation")
        }
        
       let operation1 = BlockOperation {
            for i in 10...200 {
                print("🔷", i)
            }
        }
        
        
        operation1.completionBlock = {
            print("Finish operation")
        }
        
       let operation2 = BlockOperation {
            for i in 1000..<1010 {
                print("⚪️⚫️", i)
            }
            
        }
        
        operation2.completionBlock = {
            print("Finish operation")
        }
        operationQueue.addOperations([operation, operation1, operation2], waitUntilFinished: false)
        print("Hello")

        
    }
    
    
    func blockOperationAddmultipleOperations() {
        let block1 = {
            sleep(5)
            print("block1")
        }
        
        let block2 = {
            print("block2")
        }
        
        let block3 = {
            print("block3")
        }
        
        let block4 = {
            sleep(10)
            print("block4")
        }
        let operation1 = BlockOperation.init()
        
        operation1.addExecutionBlock {
            block1()
        }
        
        operation1.addExecutionBlock {
            block2()
        }
        
        operation1.addExecutionBlock {
            block3()
        }
        
        operation1.addExecutionBlock {
            block4()
        }
        
        operation1.completionBlock = {
            print("operation1 is completed")
        }
        operationQueue.addOperations([operation1], waitUntilFinished: false)
        print("Hello")
    }

    
    
    
}
