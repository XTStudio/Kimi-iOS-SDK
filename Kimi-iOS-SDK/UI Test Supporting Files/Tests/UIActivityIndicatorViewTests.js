var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UIActivityIndicatorView()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.center = { x: (UIScreen.main.bounds.width) / 2.0, y: (UIScreen.main.bounds.height) / 2.0 - 64 }
        this.addSubview(this.sampleView)
        this.setupTests()
    }

    setupTests() {
        tests = [
            {
                name: "Start Animating",
                action: function () {
                    this.sampleView.color = UIColor.red
                    this.sampleView.largeStyle = true
                    this.sampleView.startAnimating()
                }.bind(this)
            },
            {
                name: "Stop Animating",
                action: function () {
                    this.sampleView.stopAnimating()
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()