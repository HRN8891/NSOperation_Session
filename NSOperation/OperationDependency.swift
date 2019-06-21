//
//  OperationDependency.swift
//  NSOperation
//
//  Created by Hiren Patel on 02/10/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class OperationDependency: NSObject {
    let operationQueue = OperationQueue.init()
    var saveOperation: BlockOperation?
    let operationQueueSecond = OperationQueue.init()

    func operationDepedency() {
        operationQueue.isSuspended = true
        self.operationQueue.maxConcurrentOperationCount = 3
        
        let settingOperation = BlockOperation.init {
            sleep(2)
            print("settingOperation is finished")
        }
        
        
        let versionOperation = BlockOperation.init {
            sleep(2)
            print("versionOperation is finished")
        }
        
        let newsOperation = BlockOperation.init {
            sleep(15)
            print("newsOperation is finished")
        }
        
        let sessionOperation = BlockOperation.init {
            sleep(2)
            print("sessionOperation is finished")
        }
        
        let beaconOperation = BlockOperation.init {
            sleep(20)
            print("beaconOperation is finished")
        }
        
        let feedbackOperation = BlockOperation.init {
            sleep(2)
            print("feedbackOperation is finished")
        }
        
        
        let favouriteOperation = BlockOperation.init {
            sleep(2)
            print("favouriteOperation is finished")
        }
        
        
        let videoOperation = BlockOperation.init {
            sleep(2)
            print("videoOperation is finished")
        }
        
        saveOperation = BlockOperation.init {
            sleep(2)
            print("saveOperation is finished")
        }
        
        sessionOperation.name = "sessionOperation"
        versionOperation.name = "versionOperation"
        settingOperation.name = "settingOperation"
        newsOperation.name = "newsOperation"
        beaconOperation.name = "beaconOperation"
        feedbackOperation.name = "feedbackOperation"
        favouriteOperation.name = "favouriteOperation"
        videoOperation.name = "videoOperation"
        saveOperation?.name = "saveOperation"
        
        versionOperation.addDependency(settingOperation)
        sessionOperation.addDependency(versionOperation)
        newsOperation.addDependency(versionOperation)
        beaconOperation.addDependency(versionOperation)
        
        feedbackOperation.addDependency(sessionOperation)
        favouriteOperation.addDependency(sessionOperation)
        videoOperation.addDependency(sessionOperation)
        
        saveOperation?.addDependency(feedbackOperation)
        saveOperation?.addDependency(favouriteOperation)
        saveOperation?.addDependency(videoOperation)
        saveOperation?.addDependency(newsOperation)
        saveOperation?.addDependency(beaconOperation)
        
        
        SimpleObserver.sharedSimpleObserver.observeOperation(op: settingOperation)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: versionOperation)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: sessionOperation)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: newsOperation)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: beaconOperation)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: feedbackOperation)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: favouriteOperation)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: videoOperation)
        SimpleObserver.sharedSimpleObserver.observeOperation(op: saveOperation!)
        
        operationQueue.addOperations([settingOperation, versionOperation, sessionOperation, newsOperation, beaconOperation, feedbackOperation, favouriteOperation, videoOperation, saveOperation!], waitUntilFinished: false)
        operationQueue.isSuspended = false
        
    }
    
    func operationDependancyForOtherQueue() {
        operationQueue.isSuspended = true
        self.operationQueue.maxConcurrentOperationCount = 1
        
        let firstOperation = BlockOperation.init {
            sleep(2)
            print("firstOperation is finished")
        }
        
        
        let secondOperation = BlockOperation.init {
            sleep(2)
            print("secondOperation is finished")
        }
        
        let thirdOperation = BlockOperation.init {
            sleep(2)
            print("thirdOperation is finished")
        }
        
        let fourthOperation = BlockOperation.init {
            sleep(2)
            print("fourthOperation is finished")
        }
        
       fourthOperation.addDependency(firstOperation)
        operationQueue.addOperations([firstOperation, secondOperation, thirdOperation], waitUntilFinished: false)
        operationQueueSecond.addOperation(fourthOperation)
        operationQueue.isSuspended = false


    }
    
}
