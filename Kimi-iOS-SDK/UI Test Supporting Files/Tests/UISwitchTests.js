var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UISwitch()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: (UIScreen.main.bounds.width) / 2.0, y: (UIScreen.main.bounds.height) / 2.0 - 64 }
        this.addSubview(this.sampleView)
        this.setupTests()
    }

    setupTests() {
        tests = [
            {
                name: "color",
                action: function () {
                    this.sampleView.onTintColor = UIColor.blue
                    this.sampleView.thumbTintColor = UIColor.green
                    this.sampleView.isOn = true
                }.bind(this)
            },
            {
                name: "Change Value - Tap",
                action: function () {
                    this.sampleView.accessibilityIdentifier = "Tap Require"
                    this.sampleView.on('valueChanged', function () {
                        this.sampleView.accessibilityIdentifier = "sample view"
                        this.accessibilityIdentifier += "valueChanged|"
                    }.bind(this))
                }.bind(this)
            },
            {
                name: "setOn",
                action: function () {
                    this.sampleView.setOn(true, false)
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()