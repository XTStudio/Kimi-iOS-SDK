var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UITextView()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: (UIScreen.main.bounds.width - 300) / 2.0, y: (UIScreen.main.bounds.height - 300) / 2.0 - 64, width: 300, height: 300 }
        this.addSubview(this.sampleView)
        this.setupTests()
    }

    setupTests() {
        tests = [
            {
                name: "Plain Properties",
                action: function () {
                    this.sampleView.text = "Pony"
                    this.sampleView.font = new UIFont(28)
                    this.sampleView.textColor = UIColor.red
                    this.sampleView.textAlignment = UITextAlignment.center
                    this.sampleView.editable = true
                    this.sampleView.selectable = true
                    this.sampleView.autocapitalizationType = UITextAutocapitalizationType.words
                    this.sampleView.autocorrectionType = UITextAutocorrectionType.no
                    this.sampleView.spellCheckingType = UITextSpellCheckingType.yes
                    this.sampleView.keyboardType = UIKeyboardType.ASCIICapable
                    this.sampleView.returnKeyType = UIReturnKeyType.go
                }.bind(this)
            },
            {
                name: "Focus",
                action: function () {
                    this.sampleView.on('shouldBeginEditing', function () {
                        this.accessibilityIdentifier += "shouldBeginEditing|"
                        return true
                    }.bind(this))
                    this.sampleView.on('didBeginEditing', function () {
                        this.accessibilityIdentifier += "didBeginEditing|"
                        return true
                    }.bind(this))
                    this.sampleView.text = ""
                    this.sampleView.focus()
                }.bind(this)
            },
            {
                name: "Input Sentense - Input",
                action: function () {
                    this.sampleView.accessibilityIdentifier = "Input Require"
                    this.sampleView.on('shouldChange', function () {
                        this.sampleView.accessibilityIdentifier = "sample view"
                        this.accessibilityIdentifier += "shouldChange|"
                        return true
                    }.bind(this))
                }.bind(this)
            },
            {
                name: "Blur",
                action: function () {
                    this.sampleView.on('shouldEndEditing', function () {
                        this.accessibilityIdentifier += "shouldEndEditing|"
                        return true
                    }.bind(this))
                    this.sampleView.on('didEndEditing', function () {
                        this.accessibilityIdentifier += "didEndEditing|"
                        return true
                    }.bind(this))
                    this.sampleView.blur()
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()