//
//  ViewController.swift
//  testMenuNotification
//
//  Created by James Tang on 16/10/2019.
//  Copyright © 2019 James Tang. All rights reserved.
//

import UIKit

class MenuController: UIMenuController {
    override func hideMenu() {
        super.hideMenu()
    }

    override func hideMenu(from targetView: UIView) {
        super.hideMenu(from: targetView)
    }
}

class ViewController: UIViewController {

    let longPressGesture = UILongPressGestureRecognizer()
    let menuController = MenuController()
    var willShowMenuNotificationObserver: Any!
    var willHideMenuNotificationObserver: Any!
    var menuFrameDidChangeNotificationObserver: Any!
    var didHideMenuNotificationObserver: Any!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        longPressGesture.addTarget(self, action: #selector(handleLongPressGesture(_:)))
        view.addGestureRecognizer(longPressGesture)

        willShowMenuNotificationObserver = NotificationCenter.default.addObserver(forName: UIMenuController.willShowMenuNotification, object: nil, queue: OperationQueue.main) { (notification) in
            Swift.print("LLL willShowMenuNotification")
        }

        willHideMenuNotificationObserver = NotificationCenter.default.addObserver(forName: UIMenuController.willHideMenuNotification, object: nil, queue: OperationQueue.main) { (notification) in
            Swift.print("LLL willHideMenuNotification")
        }

        didHideMenuNotificationObserver = NotificationCenter.default.addObserver(forName: UIMenuController.didHideMenuNotification, object: nil, queue: OperationQueue.main) { (notification) in
            Swift.print("LLL didHideMenuNotification")
        }

        menuFrameDidChangeNotificationObserver = NotificationCenter.default.addObserver(forName: UIMenuController.menuFrameDidChangeNotification, object: nil, queue: OperationQueue.main) { (notification) in
            Swift.print("LLL menuFrameDidChangeNotification")
        }
    }

    @objc func handleLongPressGesture(_ longPressGesture: UILongPressGestureRecognizer) {

        guard longPressGesture.state == .began else {
            return
        }

        let point = longPressGesture.location(in: self.view)
        let rect = CGRect(x: point.x, y: point.y, width: 10, height: 10)

        Swift.print("LLL longPress \(point)")

        menuController.showMenu(from: self.view, rect: rect)

    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func copy(_ sender: Any?) {
        Swift.print("copy")
    }


}

