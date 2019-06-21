//
//  AlertOperation.swift
//  NSOperation
//
//  Created by Hiren Patel on 02/10/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class AlertOperation: BaseOperation {
    // MARK: Properties
    
    private let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    private let presentationContext: UIViewController?
    
    var title: String? {
        get {
            return alertController.title
        }
        set {
            alertController.title = newValue
        }
    }
    
    var message: String? {
        get {
            return alertController.message
        }
        set {
            alertController.message = newValue
        }
    }
    init(presentationContext: UIViewController) {
        self.presentationContext = presentationContext
        super.init()
    }
    
    func addAction(title: String, style: UIAlertActionStyle = .default, handler: @escaping (AlertOperation) -> Void = { _ in }) {
        let action = UIAlertAction(title: title, style: style) { [weak self] _ in
            if let strongSelf = self {
                handler(strongSelf)
            }
            self?.finish(true)
        }
        
        alertController.addAction(action)
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
    
     func execute() {
        guard let presentationContext = presentationContext else {
            self.finish(true)
            return
        }
        DispatchQueue.main.async {
            if self.alertController.actions.isEmpty {
                self.addAction(title: "OK")
            }
            presentationContext.present(self.alertController, animated: true, completion: nil)
        }
    }
}
