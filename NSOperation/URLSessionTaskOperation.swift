//
//  URLSessionTaskOperation.swift
//  NSOperation
//
//  Created by Hiren Patel on 02/10/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

private var URLSessionTaksOperationKVOContext = 0

class URLSessionTaskOperation: BaseOperation {
    var task: URLSessionTask?
    
    override init() {
        super.init()
    }
    
     func execute() {
        let path = "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_month.geojson"
        let url = URL(string: path)
        let session = URLSession.shared
        self.task = session.dataTask(with:url!) { (data, response, error) -> Void in
            print(data)
            self.finish(true)
        }
        task?.resume()
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
        execute()
    }
    
    override func cancel() {
        task?.cancel()
        super.cancel()
    }
}
