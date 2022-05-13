//
//  ContainerViewController.swift
//  ios-ui-sidemenu
//
//  Created by 김정민 on 2022/05/11.
//

import UIKit


final class ContainerViewController: ViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    private let menuVC = MenuViewController()
    private let homeVC = HomeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVCs()
    }
    
    private func addChildVCs() {
        // Menu
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    
    func didTapMenuButton() {
        // Animate the menu
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.homeVC.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
                
                
            } completion: { done in
                if done {
                    
                }
            }

        case .opened:
            break
        }
    }
    
}
