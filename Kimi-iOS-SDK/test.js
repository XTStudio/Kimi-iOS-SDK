
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
        var aView = new UIView
        aView.backgroundColor = UIColor.redColor
        var bView = new UIView
        bView.backgroundColor = UIColor.grayColor
        var cView = new UIView
        cView.backgroundColor = UIColor.greenColor
        var stackView = new UIStackView([aView, bView, cView])
        stackView.layoutArrangedSubview(aView, { height: 66 })
        stackView.layoutArrangedSubview(bView, { width: 66, height: 88 })
        stackView.layoutArrangedSubview(cView, { width: 88, height: 100 })
        stackView.frame = { x: 0, y: 200, width: UIScreen.mainScreen.bounds.width, height: 200 }
        stackView.axis = UILayoutConstraintAxis.horizontal
        stackView.distribution = UIStackViewDistribution.fill
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing = 20
        this.view.addSubview(stackView)
    }

}

main = new MyViewController()