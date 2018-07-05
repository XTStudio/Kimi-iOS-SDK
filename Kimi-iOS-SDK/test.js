// var main = new UIViewController;
// main.view.backgroundColor = UIColor.yellowColor;
// main.frame = { x: 0, y: 44, width: UIScreen.mainScreen.bounds.width, height: 44 }
// main.backgroundColor = UIColor.yellowColor

// console.log(main.alpha)

class SecondViewController extends UIViewController {

    viewDidLoad() {
        super.viewDidLoad()
        this.title = "Yellow"
        this.view.backgroundColor = UIColor.yellowColor;
        this.view.addGestureRecognizer(new UITapGestureRecognizer().on('touch', function () {
            this.navigationController.popViewController()
        }.bind(this)))
        var redView = new UIView()
        redView.backgroundColor = UIColor.redColor
        this.on('viewWillLayoutSubviews', function (sender) {
            redView.frame = { x: 0, y: sender.safeAreaInsets.top, width: 44, height: 44 }
        })
        this.view.addSubview(redView)
    }

    viewWillAppear() {
        super.viewWillAppear()
        this.navigationController.setNavigationBarHidden(true, false)
    }

    viewWillDisappear() {
        super.viewWillDisappear()
        this.navigationController.setNavigationBarHidden(false, false)
    }

}

class MyViewController extends UIViewController {

    viewDidLoad() {
        super.viewDidLoad()
        // this.title = "Green"
        this.navigationItem.title = "Green"
        this.view.backgroundColor = UIColor.greenColor;
        this.view.addGestureRecognizer(new UITapGestureRecognizer().on('touch', function () {
            this.navigationController.pushViewController(new SecondViewController, true)
        }.bind(this)))
        var redView = new UIView()
        redView.backgroundColor = UIColor.redColor
        this.on('viewWillLayoutSubviews', function (sender) {
            redView.frame = { x: 0, y: sender.safeAreaInsets.top, width: 44, height: 44 }
        })
        this.view.addSubview(redView)
        var naviItem = new UIBarButtonItem()
        naviItem.title = "Test"
        naviItem.on('touch', function () {
            this.navigationController.pushViewController(new SecondViewController, true)
        }.bind(this))
        this.navigationItem.rightBarButtonItem = naviItem
    }

}

// var my = new MyViewController
// var first = new UINavigationController(my)
// first.tabBarItem.title = "Home"
// var tabBarController = new UITabBarController()
// tabBarController.setViewControllers([first])
// var main = tabBarController;
// main.navigationBar.translucent = false

var pageViewController = new UIPageViewController(true)
pageViewController.loops = true
// pageViewController.bounces = false
pageViewController.pageItems = [
    new MyViewController,
    new SecondViewController,
]
main = pageViewController
// main.currentPage = new MyViewController
// main.on('beforeViewController', function() { return new SecondViewController })
// main.on('afterViewController', function() { return new SecondViewController })

// DispatchQueue.main.asyncAfter(3.0, function () {
//     main.scrollToNextPage()
// })
// DispatchQueue.main.asyncAfter(6.0, function () {
//     main.scrollToPreviousPage()
// })