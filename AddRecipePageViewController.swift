//
//  AddRecipePageViewController.swift
//  
//
//  Created by Hannes on 27.02.17.
//
//

import UIKit


class AddRecipePageViewController: UIPageViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newInformationViewController(information: "General"),
                self.newInformationViewController(information: "Ingredients"),
                self.newInformationViewController(information: "Instruction")]
    }()
    
    private func newInformationViewController(information: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(information)Information")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
}


extension AddRecipePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
}
