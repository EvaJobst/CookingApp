//
//  AddRecipePageControlViewController.swift
//  CookingApp
//
//  Created by Hannes on 27.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class AddRecipePageControlViewController: UIViewController {
    
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var PageControl: UIPageControl!

    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addRecipePageViewController = segue.destination as? AddRecipePageViewController {
            addRecipePageViewController.addRecipeDelegate = self
        }
    }
    
}

extension AddRecipePageControlViewController: AddRecipePageViewControllerDelegate {
    
    
    func addRecipePageViewController(addRecipePageViewController: AddRecipePageViewController, didUpdatePageCount count: Int) {
            PageControl.numberOfPages = count
        }
    
    func addRecipePageViewController(addRecipePageViewController: AddRecipePageViewController, didUpdatePageIndex index: Int) {
        PageControl.currentPage = index
    }
    
}
