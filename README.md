# ios-ui-sidemenu
- [side-menu](https://www.youtube.com/watch?v=1hzPFAYcuUI&t=1406s) 클론코딩 
<img src="https://user-images.githubusercontent.com/26668309/168417549-ecd1a808-c551-4ed9-8823-05f34c66cf81.gif" width = 30%>

- Container View 
```Swift 
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

``` 
