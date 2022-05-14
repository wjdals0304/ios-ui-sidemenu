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
    private var navVC: UINavigationController?
    lazy var infoVC = InfoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVCs()
    }
    
    private func addChildVCs() {
        // Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        print(#function)
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        // Animate the menu
        switch menuState {
        case .closed:
            // open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }

        case .opened:
            //close it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    
                    DispatchQueue.main.async {
                        completion?()
                    }

                }
            }

        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {

    func didSelect(menuItem: MenuViewController.MenuOptions) {
        print("did select")
        toggleMenu { [weak self] in
            switch menuItem {
            case .home:
                self?.resetToHome()
            case .info :
                self?.addInfo()
            case .appRating:
                break
            case .shareApp:
                break
            case .settings :
                break
          }
        }
    }
    
    func addInfo() {
        let vc = infoVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    
    func resetToHome() {
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        homeVC.title = "Home"
    }
    
    
}
