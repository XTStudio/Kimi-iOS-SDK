var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UIScrollView()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 }
        this.addSubview(this.sampleView)
        this.setupSubviews()
        this.setupTests()
    }

    setupSubviews() {
        for (var index = 0; index < 100; index++) {
            var subview = new UIView
            subview.frame = { x: 0, y: index * 88, width: 44, height: 44 }
            subview.backgroundColor = new UIColor(1, 0, 0, 1.0 / index)
            this.sampleView.addSubview(subview)
        }
    }

    setupTests() {
        tests = [
            {
                name: "Plain Properties",
                action: function () {
                    this.sampleView.contentOffset = { x: 0, y: 300 }
                    this.sampleView.contentSize = { width: 1, height: 2000 }
                    this.sampleView.contentInset = { top: 44, left: 0, bottom: 0, right: 0 }
                    this.sampleView.directionalLockEnabled = true
                    this.sampleView.bounces = true
                    this.sampleView.alwaysBounceVertical = true
                    this.sampleView.alwaysBounceHorizontal = true
                    this.sampleView.pagingEnabled = true
                    this.sampleView.scrollEnabled = false
                    this.sampleView.showsHorizontalScrollIndicator = false
                    this.sampleView.showsVerticalScrollIndicator = false
                    this.sampleView.scrollsToTop = true
                }.bind(this)
            },
            {
                name: "Reset State",
                action: function () {
                    this.sampleView.directionalLockEnabled = true
                    this.sampleView.bounces = true
                    this.sampleView.alwaysBounceVertical = true
                    this.sampleView.alwaysBounceHorizontal = true
                    this.sampleView.pagingEnabled = false
                    this.sampleView.scrollEnabled = true
                    this.sampleView.showsHorizontalScrollIndicator = true
                    this.sampleView.showsVerticalScrollIndicator = true
                    this.sampleView.scrollsToTop = true
                }.bind(this)
            },
            {
                name: "setContentOffset - Wait",
                action: function () {
                    this.sampleView.setContentOffset({ x: 0, y: 600 }, true)
                }.bind(this)
            },
            {
                name: "scrollRectToVisible - Wait",
                action: function () {
                    this.sampleView.scrollRectToVisible({ x: 0, y: 0, width: 1, height: 1 }, true)
                }.bind(this)
            },
            {
                name: "Delegates - Pan",
                action: function () {
                    this.sampleView.on('didScroll', function () {
                        this.accessibilityIdentifier += "didScroll|"
                    }.bind(this))
                    this.sampleView.on('willBeginDragging', function () {
                        this.accessibilityIdentifier += "willBeginDragging|"
                    }.bind(this))
                    this.sampleView.on('willEndDragging', function () {
                        this.accessibilityIdentifier += "willEndDragging|"
                    }.bind(this))
                    this.sampleView.on('didEndDragging', function () {
                        this.accessibilityIdentifier += "didEndDragging|"
                        this.sampleView.accessibilityIdentifier = ""
                    }.bind(this))
                    this.sampleView.on('willBeginDecelerating', function () {
                        this.accessibilityIdentifier += "willBeginDecelerating|"
                    }.bind(this))
                    this.sampleView.on('didEndDecelerating', function () {
                        this.accessibilityIdentifier += "didEndDecelerating|"
                    }.bind(this))
                    this.sampleView.accessibilityIdentifier = "Pan Require"
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()