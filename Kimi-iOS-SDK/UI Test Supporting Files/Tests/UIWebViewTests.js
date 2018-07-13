var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UIWebView()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 }
        this.addSubview(this.sampleView)
        this.setupWebView()
        this.setupTests()
    }

    setupWebView() {
        this.sampleView.on('newRequest', function () {
            this.accessibilityIdentifier += "newRequest|"
            return true
        }.bind(this))
        this.sampleView.on('didStart', function () {
            this.accessibilityIdentifier += "didStart|"
        }.bind(this))
        this.sampleView.on('didFinish', function () {
            this.sampleView.accessibilityIdentifier = "sample view"
            this.accessibilityIdentifier += "didFinish|"
        }.bind(this))
        this.sampleView.on('didFail', function () {
            this.sampleView.accessibilityIdentifier = "sample view"
            this.accessibilityIdentifier += "didFail|"
        }.bind(this))
    }

    setupTests() {
        tests = [
            {
                name: "loadRequest Fail - Wait",
                action: function () {
                    this.sampleView.accessibilityIdentifier = "Wait Require"
                    var request = new URLRequest(URL.URLWithString('http://localhost.mustfail/'), undefined, 3)
                    this.sampleView.loadRequest(request)
                }.bind(this)
            },
            {
                name: "loadRequest Finish - Wait",
                action: function () {
                    this.sampleView.accessibilityIdentifier = "Wait Require"
                    var request = new URLRequest(URL.URLWithString('http://httpbin.org/status/200'), undefined, 3)
                    this.sampleView.loadRequest(request)
                }.bind(this)
            },
            {
                name: "loadHTML - Wait",
                action: function () {
                    this.sampleView.accessibilityIdentifier = "Wait Require"
                    this.sampleView.loadHTMLString('<title>Pony\'s Page</title>', URL.URLWithString('http://localhost/'));
                }.bind(this)
            },
            {
                name: "evaluateScript - Wait",
                action: function () {
                    this.sampleView.accessibilityIdentifier = "Wait Require"
                    this.sampleView.evaluateJavaScript('1 + 1', function(result, error) {
                        if (result === 2 && error === undefined) {
                            this.accessibilityIdentifier += "evaluateScript|";
                            this.sampleView.accessibilityIdentifier = "sample view"
                        }
                    }.bind(this))
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()