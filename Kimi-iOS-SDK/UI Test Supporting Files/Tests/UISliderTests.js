var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UISlider()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: (UIScreen.main.bounds.width - 200) / 2.0, y: (UIScreen.main.bounds.height - 44) / 2.0 - 64, width: 200, height: 44 }
        this.addSubview(this.sampleView)
        this.setupTests()
    }

    setupTests() {
        tests = [
            {
                name: "Plain Props",
                action: function () {
                    this.sampleView.minimumTrackTintColor = UIColor.green
                    this.sampleView.maximumTrackTintColor = UIColor.red
                    this.sampleView.thumbTintColor = UIColor.blue
                    this.sampleView.minimumValue = 0
                    this.sampleView.maximumValue = 100
                    this.sampleView.value = 50
                }.bind(this)
            },
            {
                name: "Change Value - Slide",
                action: function () {
                    this.sampleView.accessibilityIdentifier = "Slide Require"
                    this.sampleView.on('valueChanged', function () {
                        this.sampleView.accessibilityIdentifier = "sample view"
                        this.accessibilityIdentifier += "valueChanged|"
                    }.bind(this))
                }.bind(this)
            },
            {
                name: "setValue",
                action: function () {
                    this.sampleView.setValue(0, false)
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()