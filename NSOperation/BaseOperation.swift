//
//  BaseOperation.swift
//  NSOperation
//
//  Created by Hiren Patel on 12/06/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class BaseOperation: BlockOperation {
    
    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
//    override var isAsynchronous: Bool {
//        return true
//    }
//    
//    override var isConcurrent: Bool {
//        return true
//    }
    private var _asynchronous = true {
        willSet {
            willChangeValue(forKey: "isAsynchronous")
        }
        didSet {
            didChangeValue(forKey: "isAsynchronous")
        }
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    func executing(_ executing: Bool) {
        _executing = executing
    }
    
    func asynchronous(_ asynchronous: Bool) {
        _asynchronous = asynchronous
    }
    
    func finish(_ finished: Bool) {
        _finished = finished
    }
}

public typealias OperationBlock = (@escaping () -> Void) -> Void

class BaseBlockOperation: BaseOperation {

    fileprivate let block: OperationBlock?
    
    public init(block: OperationBlock? = nil) {
        self.block = block
        super.init()
    }
    
    override final func start() {
        super.start()
        if isCancelled {
            executing(false)
            finish(true)
        }
    }
    
    override final func main() {
        print("main")
        executing(true)

        if let block = block {
            block {
                self.finish(true)
            }
        } else {
            self.finish(true)
        }
    }
}
