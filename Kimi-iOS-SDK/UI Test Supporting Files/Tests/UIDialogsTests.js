var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.setupTests()
    }

    setupTests() {
        tests = [
            {
                name: "Alert - Tap",
                action: function () {
                    var dialog = new UIAlert("Alert Message", "Tap Require")
                    dialog.show(function () {
                        this.accessibilityIdentifier += "Alert|"
                    }.bind(this))
                }.bind(this)
            },
            {
                name: "UIPrompt - Confirm",
                action: function () {
                    var dialog = new UIPrompt("Please input username")
                    dialog.confirmTitle = "Tap Require"
                    dialog.placeholder = "Please input username here."
                    dialog.defaultValue = "PonyCui"
                    dialog.show(function (text) {
                        if (text === "PonyCui") {
                            this.accessibilityIdentifier += "UIPrompt,Confirm|"
                        }
                    }.bind(this))
                }.bind(this)
            },
            {
                name: "UIPrompt - Cancel",
                action: function () {
                    var dialog = new UIPrompt("Please input username")
                    dialog.cancelTitle = "Tap Require"
                    dialog.placeholder = "Please input username here."
                    dialog.defaultValue = "PonyCui"
                    dialog.show(function (text) {
                        if (text === "PonyCui") {
                            this.accessibilityIdentifier = ""
                        }
                    }.bind(this), function () {
                        this.accessibilityIdentifier += "UIPrompt,Cancel|"
                    }.bind(this))
                }.bind(this)
            },
            {
                name: "UIConfirm - Confirm",
                action: function () {
                    var dialog = new UIConfirm("Pony is good boy.")
                    dialog.confirmTitle = "Tap Require"
                    dialog.show(function () {
                        this.accessibilityIdentifier += "UIConfirm,Confirm|"
                    }.bind(this))
                }.bind(this)
            },
            {
                name: "UIConfirm - Cancel",
                action: function () {
                    var dialog = new UIConfirm("Pony is good boy.")
                    dialog.cancelTitle = "Tap Require"
                    dialog.show(function () { }, function () {
                        this.accessibilityIdentifier += "UIConfirm,Cancel|"
                    }.bind(this))
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()