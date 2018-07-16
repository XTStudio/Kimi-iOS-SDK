var tests = []

class NextViewController extends UIViewController {

    viewDidLoad() {
        super.viewDidLoad()
        this.title = "Messenger"
    }

}

class RootViewController extends UIViewController {

    viewDidLoad() {
        super.viewDidLoad()
        this.title = "Root"
    }

}

class TestViewController extends UINavigationController {

    constructor(rootViewController) {
        super(rootViewController)
        this.setupTests()
    }

    setupTests() {
        tests = [
            {
                name: "rootViewController",
                action: function () {
                    if (this.childViewControllers[0] instanceof RootViewController) {
                        this.view.accessibilityIdentifier += "rootViewController|"
                    }
                }.bind(this)
            },
            {
                name: "pushViewController - Wait",
                action: function () {
                    this.pushViewController(new NextViewController)
                }.bind(this)
            },
            {
                name: "popViewController - Wait",
                action: function () {
                    this.popViewController()
                }.bind(this)
            },
            {
                name: "popToViewController - Wait",
                action: function () {
                    var a = new NextViewController
                    a.view.backgroundColor = UIColor.red
                    var b = new NextViewController
                    var c = new NextViewController
                    this.pushViewController(a, false)
                    this.pushViewController(b, false)
                    this.pushViewController(c, false)
                    this.popToViewController(a, false)
                }.bind(this)
            },
            {
                name: "popToRootViewController - Wait",
                action: function () {
                    this.popToRootViewController()
                }.bind(this)
            },
            {
                name: "setViewControllers - Wait",
                action: function () {
                    var a = new NextViewController
                    a.view.backgroundColor = UIColor.red
                    var b = new NextViewController
                    var c = new NextViewController
                    c.view.backgroundColor = UIColor.yellow
                    this.setViewControllers([a, b, c], false)
                }.bind(this)
            },
            {
                name: "UIViewController.navigationController",
                action: function () {
                    this.childViewControllers[0].navigationController.view.accessibilityIdentifier += "navigationController|"
                }.bind(this)
            },
            {
                name: "UIViewController.navigationItem - Tap",
                action: function () {
                    var lastViewController = this.childViewControllers[this.childViewControllers.length - 1]
                    var leftButtonItem = new UIBarButtonItem()
                    leftButtonItem.title = "Tap Require"
                    leftButtonItem.on('touchUpInside', function () {
                        this.view.accessibilityIdentifier += "leftButtonItem|"
                        leftButtonItem.title = "Left"
                        rightButtonItem.title = "Tap Require"
                    }.bind(this))
                    lastViewController.navigationItem.leftBarButtonItem = leftButtonItem
                    var rightButtonItem = new UIBarButtonItem()
                    rightButtonItem.title = "Right"
                    lastViewController.navigationItem.rightBarButtonItems = [rightButtonItem]
                    rightButtonItem.on('touchUpInside', function () {
                        this.view.accessibilityIdentifier += "rightButtonItem|"
                        rightButtonItem.title = "Right"
                    }.bind(this))
                }.bind(this)
            },
            {
                name: "navigationBar",
                action: function () {
                    this.navigationBar.alpha = 0.5
                }.bind(this)
            },
            {
                name: "navigationBar.hidden - Wait",
                action: function () {
                    this.setNavigationBarHidden(true, fasle)
                }.bind(this)
            },
        ]
    }

}

var main = new TestViewController(new RootViewController)
