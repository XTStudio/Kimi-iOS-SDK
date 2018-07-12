var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UIView()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: (UIScreen.main.bounds.width - 88) / 2.0, y: (UIScreen.main.bounds.height - 88) / 2.0 - 64, width: 88, height: 88 }
        this.sampleView.backgroundColor = UIColor.black
        this.addSubview(this.sampleView)
        this.setupTests()
    }

    didAddSubview() {
        super.didAddSubview()
        if (this.testingDelegates) {
            this.accessibilityIdentifier = this.accessibilityIdentifier + "didAddSubview|"
        }
    }

    willRemoveSubview() {
        super.willRemoveSubview()
        if (this.testingDelegates) {
            this.accessibilityIdentifier = this.accessibilityIdentifier + "willRemoveSubview|"
        }
    }

    willMoveToSuperview() {
        super.willMoveToSuperview()
        if (this.testingDelegates) {
            this.accessibilityIdentifier = this.accessibilityIdentifier + "willMoveToSuperview|"
        }
    }

    didMoveToSuperview() {
        super.didMoveToSuperview()
        if (this.testingDelegates) {
            this.accessibilityIdentifier = this.accessibilityIdentifier + "didMoveToSuperview"
        }
    }

    layoutSubviews() {
        super.layoutSubviews()
        if (this.testingDelegates && this.subviews[0]) {
            this.subviews[0].frame = { x: 0, y: 0, width: 300, height: 300 };
            this.layoutIfNeeded()
        }
    }

    setupTests() {
        tests = [
            {
                name: 'Change Frame',
                action: function () {
                    this.sampleView.frame = { x: (UIScreen.main.bounds.width - 128) / 2.0, y: (UIScreen.main.bounds.height - 128) / 2.0 - 64, width: 128, height: 128 }
                }.bind(this)
            },
            {
                name: 'Change Center',
                action: function () {
                    this.sampleView.center = { x: this.sampleView.center.x, y: 128.0 }
                }.bind(this)
            },
            {
                name: 'Change Transform',
                action: function () {
                    this.sampleView.transform = { a: 0.5, b: 0.0, c: 0.0, d: 0.5, tx: 0.0, ty: 44.0 }
                }.bind(this)
            },
            {
                name: 'Set Tag / Get View Via Tag',
                action: function () {
                    this.sampleView.tag = 3000
                    this.viewWithTag(3000).backgroundColor = UIColor.gray
                }.bind(this)
            },
            {
                name: 'Get Superview and Set it\'s BackgroundColor',
                action: function () {
                    this.sampleView.superview.backgroundColor = UIColor.yellow
                }.bind(this)
            },
            {
                name: 'Get Subviews and Set it\s BackgroundColor',
                action: function () {
                    this.subviews[0].backgroundColor = UIColor.red
                }.bind(this)
            },
            {
                name: 'Remove From Superview',
                action: function () {
                    this.sampleView.removeFromSuperview()
                }.bind(this)
            },
            {
                name: 'insertSubviewAtIndex',
                action: function () {
                    var subview = new UIView
                    subview.frame = { x: 0, y: 0, width: 44, height: 44 }
                    subview.backgroundColor = UIColor.red
                    this.insertSubviewAtIndex(subview, 0)
                    var subview2 = new UIView
                    subview2.frame = { x: 11, y: 11, width: 44, height: 44 }
                    subview2.backgroundColor = UIColor.yellow
                    this.insertSubviewAtIndex(subview2, 0)
                }.bind(this)
            },
            {
                name: 'exchangeSubview',
                action: function () {
                    this.exchangeSubview(0, 1)
                }.bind(this)
            },
            {
                name: 'addSubview',
                action: function () {
                    var subview = new UIView
                    subview.frame = { x: 22, y: 22, width: 44, height: 44 }
                    subview.backgroundColor = UIColor.green
                    this.addSubview(subview)
                }.bind(this)
            },
            {
                name: 'insertSubviewBelowSubview',
                action: function () {
                    var subview = new UIView
                    subview.frame = { x: 33, y: 33, width: 44, height: 44 }
                    subview.backgroundColor = UIColor.blue
                    this.insertSubviewBelowSubview(subview, this.subviews[0])
                }.bind(this)
            },
            {
                name: 'insertSubviewAboveSubview',
                action: function () {
                    var subview = new UIView
                    subview.frame = { x: 55, y: 55, width: 44, height: 44 }
                    subview.backgroundColor = UIColor.gray
                    this.insertSubviewAboveSubview(subview, this.subviews[0])
                }.bind(this)
            },
            {
                name: 'bringSubviewToFront',
                action: function () {
                    this.bringSubviewToFront(this.subviews[0])
                }.bind(this)
            },
            {
                name: 'sendSubviewToBack',
                action: function () {
                    this.sendSubviewToBack(this.subviews[this.subviews.length - 1])
                }.bind(this)
            },
            {
                name: 'isDescendantOfView',
                action: function () {
                    if (this.subviews[0].isDescendantOfView(this)) {
                        this.backgroundColor = UIColor.white
                    }
                }.bind(this)
            },
            {
                name: 'layoutSubviews',
                action: function () {
                    this.testingDelegates = true
                    this.frame = { x: 0, y: 0, width: 400, height: 400 }
                }.bind(this)
            },
            {
                name: 'Props',
                action: function () {
                    this.testingDelegates = false
                    this.clipsToBounds = true
                    this.alpha = 0.5
                    this.hidden = true
                    this.contentMode = UIViewContentMode.scaleAspectFit
                    this.tintColor = UIColor.blue
                    this.userInteractionEnabled = false
                }.bind(this)
            },
            {
                name: 'addGestureRecognizer - Tap',
                action: function () {
                    for (var key in this.subviews) {
                        if (this.subviews.hasOwnProperty(key)) {
                            var element = this.subviews[key];
                            element.removeFromSuperview()
                        }
                    }
                    this.hidden = false
                    this.userInteractionEnabled = true
                    this.accessibilityIdentifier = "Tap Require"
                    this.addGestureRecognizer(new UITapGestureRecognizer().on('touch', function () {
                        this.accessibilityIdentifier = "main view"
                        this.backgroundColor = UIColor.red
                    }.bind(this)))
                }.bind(this)
            },
            {
                name: 'Delegates',
                action: function () {
                    this.testingDelegates = true
                    var subview = new UIView
                    this.addSubview(subview)
                    subview.removeFromSuperview()
                    this.removeFromSuperview()
                    this.testingDelegates = false
                }.bind(this)
            },
        ]
    }

}


var main = new MainView()

