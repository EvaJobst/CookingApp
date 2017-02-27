//
//  AddRecipePageViewController.swift
//  
//
//  Created by Hannes on 27.02.17.
//
//

import UIKit


class AddRecipePageViewController: UIPageViewController {
    
    
    weak var addRecipeDelegate: AddRecipePageViewControllerDelegate?
    
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newInformationViewController(information: "General"),
                self.newInformationViewController(information: "Ingredients"),
                self.newInformationViewController(information: "Instructions")]
    }()
    
    
    
    
    private func newInformationViewController(information: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(information)Information")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        addRecipeDelegate?.addRecipePageViewController(addRecipePageViewController: self, didUpdatePageCount: orderedViewControllers.count)
    }
    
}


extension AddRecipePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ viewControllerBeforepageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}


extension AddRecipePageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            addRecipeDelegate?.addRecipePageViewController(addRecipePageViewController: self, didUpdatePageIndex: index)
        }
    }
    
}

protocol AddRecipePageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func addRecipePageViewController(addRecipePageViewController: AddRecipePageViewController, didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func addRecipePageViewController(addRecipePageViewController: AddRecipePageViewController, didUpdatePageIndex index: Int)
    
}
