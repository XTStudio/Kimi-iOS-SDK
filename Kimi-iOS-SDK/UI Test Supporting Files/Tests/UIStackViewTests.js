var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UIStackView()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: 0, y: 0, width: 300, height: 88 }
        this.addSubview(this.sampleView)
        this.setupTests()
    }

    setupTests() {
        tests = [
            {
                name: "distribution = fill - Wait",
                action: function () {
                    this.redView = new UIView
                    this.redView.backgroundColor = UIColor.red
                    this.redView.tag = 100
                    this.yellowView = new UIView
                    this.yellowView.backgroundColor = UIColor.yellow
                    this.yellowView.tag = 101
                    this.blueView = new UIView
                    this.blueView.backgroundColor = UIColor.blue
                    this.blueView.tag = 102
                    this.sampleView.addArrangedSubview(this.redView)
                    this.sampleView.addArrangedSubview(this.yellowView)
                    this.sampleView.addArrangedSubview(this.blueView)
                    this.sampleView.layoutArrangedSubview(this.yellowView, { width: 50 })
                    this.sampleView.layoutArrangedSubview(this.blueView, { width: 50 })
                    this.sampleView.axis = UILayoutConstraintAxis.horizontal
                    this.sampleView.distribution = UIStackViewDistribution.fill
                }.bind(this)
            },
            {
                name: "distribution = fillEqually - Wait",
                action: function () {
                    this.sampleView.layoutArrangedSubview(this.yellowView)
                    this.sampleView.layoutArrangedSubview(this.blueView)
                    this.sampleView.distribution = UIStackViewDistribution.fillEqually
                    this.sampleView.alignment = UIStackViewAlignment.fill
                }.bind(this)
            },
            {
                name: "distribution = fillProportionally - Wait",
                action: function () {
                    this.sampleView.spacing = 30
                    this.sampleView.distribution = UIStackViewDistribution.fillProportionally
                    this.sampleView.alignment = UIStackViewAlignment.fill
                }.bind(this)
            },
            {
                name: "distribution = equalSpacing - Wait",
                action: function () {
                    this.sampleView.spacing = 0
                    this.sampleView.layoutArrangedSubview(this.redView, { width: 50 })
                    this.sampleView.layoutArrangedSubview(this.yellowView, { width: 80 })
                    this.sampleView.layoutArrangedSubview(this.blueView, { width: 100 })
                    this.sampleView.distribution = UIStackViewDistribution.equalSpacing
                    this.sampleView.alignment = UIStackViewAlignment.fill
                }.bind(this)
            },
            {
                name: "distribution = equalCentering - Wait",
                action: function () {
                    this.sampleView.spacing = 0
                    this.sampleView.layoutArrangedSubview(this.redView, { width: 50 })
                    this.sampleView.layoutArrangedSubview(this.yellowView, { width: 80 })
                    this.sampleView.layoutArrangedSubview(this.blueView, { width: 100 })
                    this.sampleView.distribution = UIStackViewDistribution.equalCentering
                    this.sampleView.alignment = UIStackViewAlignment.fill
                }.bind(this)
            },
            {
                name: "alignment = fill",
                action: function () { }.bind(this)
            },
            {
                name: "alignment = leading - Wait",
                action: function () {
                    this.sampleView.layoutArrangedSubview(this.redView, { width: 50, height: 44 })
                    this.sampleView.layoutArrangedSubview(this.yellowView, { width: 80, height: 55 })
                    this.sampleView.layoutArrangedSubview(this.blueView, { width: 100, height: 66 })
                    this.sampleView.alignment = UIStackViewAlignment.leading
                }.bind(this)
            },
            {
                name: "alignment = center - Wait",
                action: function () {
                    this.sampleView.layoutArrangedSubview(this.redView, { width: 50, height: 44 })
                    this.sampleView.layoutArrangedSubview(this.yellowView, { width: 80, height: 55 })
                    this.sampleView.layoutArrangedSubview(this.blueView, { width: 100, height: 66 })
                    this.sampleView.alignment = UIStackViewAlignment.center
                }.bind(this)
            },
            {
                name: "alignment = trailing - Wait",
                action: function () {
                    this.sampleView.layoutArrangedSubview(this.redView, { width: 50, height: 44 })
                    this.sampleView.layoutArrangedSubview(this.yellowView, { width: 80, height: 55 })
                    this.sampleView.layoutArrangedSubview(this.blueView, { width: 100, height: 66 })
                    this.sampleView.alignment = UIStackViewAlignment.trailing
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()