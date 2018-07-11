class MyViewController extends UIViewController {

    viewDidLoad() {
        super.viewDidLoad()
        this.view.backgroundColor = UIColor.yellow
        this.displayLink = new CADisplayLink(function () {
            this.view.alpha -= 0.01
            if (this.view.alpha < 0.0) {
                this.view.alpha = 1.0
            }
        }.bind(this))
        this.displayLink.active()
        DispatchQueue.main.asyncAfter(3.0, function(){
            this.displayLink.invalidate()
        }.bind(this))
    }

}

main = new MyViewController()