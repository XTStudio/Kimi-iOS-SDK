var tests = []

class TestViewController extends UITabBarController {

    constructor(rootViewController) {
        super(rootViewController)
        this.setupTests()
    }

    setupTests() {
        tests = [
            {
                name: "setViewControllers",
                action: function () {
                    var a = new UIViewController
                    a.view.backgroundColor = UIColor.yellow
                    var b = new UIViewController
                    b.title = "Red"
                    b.view.backgroundColor = UIColor.red
                    var c = new UIViewController
                    c.view.backgroundColor = UIColor.gray
                    this.setViewControllers([a, b, c], false)
                }.bind(this)
            },
            {
                name: "selectedIndex",
                action: function () {
                    this.selectedIndex = 1
                }.bind(this)
            },
            {
                name: "selectedViewController",
                action: function () {
                    if (this.selectedViewController.title === "Red") {
                        this.view.accessibilityIdentifier += "selectedViewController|"
                    }
                }.bind(this)
            },
        ]
    }

}

var main = new TestViewController()
