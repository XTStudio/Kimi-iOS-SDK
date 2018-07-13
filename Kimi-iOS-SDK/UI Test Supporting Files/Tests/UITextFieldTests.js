var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UITextField()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: (UIScreen.main.bounds.width - 200) / 2.0, y: (UIScreen.main.bounds.height - 44) / 2.0 - 64, width: 200, height: 44 }
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
                    this.sampleView.placeholder = "Username"
                    this.sampleView.clearsOnBeginEditing = true
                    this.sampleView.clearButtonMode = UITextFieldViewMode.always
                    var leftView = new UIView
                    leftView.frame = { x: 0, y: 0, width: 44, height: 44 }
                    leftView.accessibilityIdentifier = "left view"
                    this.sampleView.leftView = leftView
                    this.sampleView.leftViewMode = UITextFieldViewMode.always
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
                name: "Clear - Clear",
                action: function () {
                    this.sampleView.accessibilityIdentifier = "Clear Require"
                    this.sampleView.on('shouldClear', function () {
                        this.sampleView.accessibilityIdentifier = "sample view"
                        this.accessibilityIdentifier += "shouldClear|"
                        return true
                    }.bind(this))
                }.bind(this)
            },
            {
                name: "Return - Return",
                action: function () {
                    this.sampleView.accessibilityIdentifier = "Return Require"
                    this.sampleView.on('shouldReturn', function () {
                        this.sampleView.accessibilityIdentifier = "sample view"
                        this.accessibilityIdentifier += "shouldReturn|"
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