//
//  PageViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/4/15.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIScrollViewDelegate {
    
    static var currentPage: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        for view: UIView in view.subviews {
            if (view is UIScrollView) {
                (view as? UIScrollView)?.delegate = self
                break
            }
        }
        
        let firstViewController = orderedViewControllers[1]
        setViewControllers([firstViewController],
                           direction: .forward, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if PageViewController.currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: CGFloat(scrollView.bounds.size.width), y: CGFloat(0))
        }
        else if PageViewController.currentPage == 2 && scrollView.contentOffset.x > scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: CGFloat(scrollView.bounds.size.width), y: CGFloat(0))
        }
        
    }
    
    //array to reference the view controllers to page through
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.functionViewController(page: "Doing"),
                self.functionViewController(page: "Main"),
                self.functionViewController(page: "Done")]
    }()
    
    private func functionViewController(page: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"\(page)ViewController")
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        PageViewController.currentPage -= 1
        
        guard PageViewController.currentPage >= 0 else {
            PageViewController.currentPage = 0
            return nil
        }
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
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
        
        PageViewController.currentPage += 1
        
        if PageViewController.currentPage > 2 {
            PageViewController.currentPage = 2
        }
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
