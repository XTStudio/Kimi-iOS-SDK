var tests = []

class ChildViewController extends UIViewController {

    willMoveToParentViewController(parent) {
        super.willMoveToParentViewController(parent)
        if (parent) {
            parent.view.accessibilityIdentifier += "willMoveToParentViewController|"
        }
    }

    didMoveToParentViewController(parent) {
        super.didMoveToParentViewController(parent)
        if (parent) {
            parent.view.accessibilityIdentifier += "didMoveToParentViewController|"
        }
    }


}

class TestViewController extends UIViewController {

    constructor() {
        super()
        this.setupTests()
    }

    viewDidLoad() {
        super.viewDidLoad()
        this.view.accessibilityIdentifier = "viewDidLoad|"
        this.on('viewWillLayoutSubviews', function () {
            this.view.accessibilityIdentifier += "onViewWillLayoutSubviews|"
        }.bind(this))
    }

    viewWillAppear() {
        super.viewWillAppear()
        this.view.accessibilityIdentifier += "viewWillAppear|"
    }

    viewDidAppear() {
        super.viewDidAppear()
        this.view.accessibilityIdentifier += "viewDidAppear|"
    }

    viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        this.view.accessibilityIdentifier += "viewWillLayoutSubviews|"
    }

    viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        this.view.accessibilityIdentifier += "viewDidLayoutSubviews|"
    }

    setupTests() {
        tests = [
            {
                name: "viewDidLoad & viewWillAppear & viewDidAppear",
                action: function () {

                }.bind(this)
            },
            {
                name: "viewWillLayoutSubviews",
                action: function () { }.bind(this)
            },
            {
                name: "viewDidLayoutSubviews",
                action: function () { }.bind(this)
            },
            {
                name: "safeAreaInsets",
                action: function () {
                    if (this.safeAreaInsets.top > 0) {
                        this.view.accessibilityIdentifier += "safeAreaInsets|"
                    }
                }.bind(this)
            },
            {
                name: "addChildViewController & removeFromParentViewController",
                action: function () {
                    var child = new ChildViewController
                    this.addChildViewController(child)
                    child.didMoveToParentViewController(this)
                    if (child.parentViewController == this && this.childViewControllers[0] == child) {
                        this.view.accessibilityIdentifier += "addChildViewController|"
                    }
                    child.removeFromParentViewController()
                    if (child.parentViewController === undefined) {
                        this.view.accessibilityIdentifier += "removeFromParentViewController|"
                    }
                }.bind(this)
            },
            {
                name: "presentViewController - Wait",
                action: function () {
                    var next = new UIViewController
                    this.presentViewController(next, false, function () {
                        if (next.presentingViewController == this && this.presentedViewController == next) {
                            next.view.backgroundColor = UIColor.yellow
                            this.view.accessibilityIdentifier += "presentViewController|"
                            this.dismissViewController(false)
                        }
                    }.bind(this))
                }.bind(this)
            },
        ]
    }

}

var main = new TestViewController
