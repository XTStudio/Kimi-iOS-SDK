var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UILabel()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: (UIScreen.main.bounds.width - 200) / 2.0, y: (UIScreen.main.bounds.height - 200) / 2.0 - 64, width: 200, height: 200 }
        this.addSubview(this.sampleView)
        this.setupTests()
    }

    setupTests() {
        tests = [
            {
                name: "Plain Text",
                action: function () {
                    this.sampleView.text = "Hello, World!"
                    this.sampleView.font = new UIFont(28)
                    this.sampleView.textColor = UIColor.red
                    this.sampleView.textAlignment = UITextAlignment.center
                    this.sampleView.lineBreakMode = UILineBreakMode.truncatingTail
                    this.sampleView.numberOfLines = 10
                }.bind(this)
            },
            {
                name: "Attributed Text",
                action: function () {
                    var text = new UIAttributedString('Hello!', {
                        [UIAttributedStringKey.foregroundColor]: UIColor.yellow,
                        [UIAttributedStringKey.underlineStyle]: true,
                    })
                    this.sampleView.attributedText = text
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()