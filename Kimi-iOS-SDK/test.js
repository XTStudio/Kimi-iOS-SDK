
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
        var aView = new UIProgressView
        aView.frame = { x: 44, y: 44, width: 200, height: 28 }
        aView.progress = 0.5
        this.view.addSubview(aView)
        DispatchQueue.global.isolate(function (aView) {
            var newValue = 0.2
            DispatchQueue.main.isolate(function (aView, newValue) {
                aView.setProgress(newValue, true)
            }, aView, newValue)
        }, aView);
    }

}

main = new MyViewController()