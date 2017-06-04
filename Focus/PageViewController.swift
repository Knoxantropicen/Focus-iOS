//
//  PageViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/4/15.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate{
    
    static var currentPage: Int = 1
    
    private var firstLaunch = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        for view: UIView in view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
        
        let firstViewController = orderedViewControllers[1]
        setViewControllers([firstViewController],
                           direction: .forward, animated: true, completion: nil)
        
        if let myView = view?.subviews.first as? UIScrollView {
            myView.canCancelContentTouches = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(enableSwipe), name:NSNotification.Name(rawValue: "enableSwipe"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disableSwipe), name:NSNotification.Name(rawValue: "disableSwipe"), object: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.backgroundColor = Style.mainBackgroundColor
        
        if firstLaunch {
            if let doingAffairArray = UserDefaults.standard.array(forKey: "DoingAffairArray") {
                DoingTableViewController.affairs = doingAffairArray as! Array<String>
            }
            if let doingModeArray = UserDefaults.standard.array(forKey: "DoingModeArray") {
                DoingTableViewController.modes = doingModeArray as! Array<String>
            }
            if let doneAffairArray = UserDefaults.standard.array(forKey: "DoneAffairArray") {
                DoneTableViewController.affairs = doneAffairArray as! Array<String>
            }
            if let doneModeArray = UserDefaults.standard.array(forKey: "DoneModeArray") {
                DoneTableViewController.modes = doneModeArray as! Array<String>
            }
            if let descriptionArray = UserDefaults.standard.array(forKey: "DescriptionArray") {
                DoneTableViewController.descriptions = descriptionArray as! Array<String>
            }
            firstLaunch = false
        }
        
        
        
        
    }
    
    func disableSwipe(notification: NSNotification){
        self.dataSource = nil
    }
    
    func enableSwipe(notification: NSNotification){
        self.dataSource = self
    }
    
//    func get_uuid() -> String {
//        let userid = UserDefaults.standard.string(forKey: "knox")
//        if userid != nil {
//            return userid!
//        } else {
//            let uuid_ref = CFUUIDCreate(nil)
//            let uuid_string_ref = CFUUIDCreateString(nil , uuid_ref)
//            let uuid = uuid_string_ref! as String
//            UserDefaults.standard.set(uuid, forKey: "knox")
//            return uuid
//        }
//    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (PageViewController.currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width) || (PageViewController.currentPage == 2 && scrollView.contentOffset.x > scrollView.bounds.size.width) {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (PageViewController.currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width) || (PageViewController.currentPage == 2 && scrollView.contentOffset.x > scrollView.bounds.size.width) {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
    
    //array to reference the view controllers to page through
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.functionViewController(page: "Doing"),
                self.functionViewController(page: "Main"),
                self.functionViewController(page: "Done")/*,
                self.functionViewController(page: "Settings")*/]
    }()
    
    private func functionViewController(page: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"\(page)ViewController")
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return 3
//    }
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return PageViewController.currentPage
//    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.backgroundColor = Style.mainBackgroundColor
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        PageViewController.currentPage -= 1
        
        if PageViewController.currentPage != viewControllerIndex {
            PageViewController.currentPage = viewControllerIndex
        }
        
        guard PageViewController.currentPage >= 0 else {
            PageViewController.currentPage = 0
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.backgroundColor = Style.mainBackgroundColor
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        PageViewController.currentPage += 1
        
        if PageViewController.currentPage != viewControllerIndex {
            PageViewController.currentPage = viewControllerIndex
        }
        
        if PageViewController.currentPage > 2 {
            PageViewController.currentPage = 2
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = 3

        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
