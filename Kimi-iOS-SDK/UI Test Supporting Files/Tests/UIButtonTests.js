var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UIButton()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: (UIScreen.main.bounds.width - 128) / 2.0, y: (UIScreen.main.bounds.height - 44) / 2.0 - 64, width: 128, height: 44 }
        this.addSubview(this.sampleView)
        this.setupTests()
    }

    setupTests() {
        tests = [
            {
                name: "Set Title",
                action: function () {
                    this.sampleView.setTitle("Hello, World!", UIControlState.normal)
                    this.sampleView.setTitle("Selected.", UIControlState.selected)
                    this.sampleView.setTitle("Disabled.", UIControlState.disabled)
                }.bind(this)
            },
            {
                name: "Set Enabled False",
                action: function () {
                    this.sampleView.enabled = false
                }.bind(this)
            },
            {
                name: "Set Selected True",
                action: function () {
                    this.sampleView.enabled = true
                    this.sampleView.selected = true
                }.bind(this)
            },
            {
                name: "contentVerticalAlignment",
                action: function () {
                    this.sampleView.selected = false
                    this.sampleView.contentVerticalAlignment = UIControlContentVerticalAlignment.top
                }.bind(this)
            },
            {
                name: "contentHorizontalAlignment",
                action: function () {
                    this.sampleView.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
                }.bind(this)
            },
            {
                name: "setTitleColor",
                action: function () {
                    this.sampleView.setTitleColor(UIColor.red, UIControlState.normal)
                }.bind(this)
            },
            {
                name: "setTitleFont",
                action: function () {
                    this.sampleView.setTitleFont(new UIFont(24))
                }.bind(this)
            },
            {
                name: "setImage",
                action: function () {
                    this.sampleView.setImage(new UIImage({ base64: '/9j/2wBDAA0JCgsKCA0LCgsODg0PEyAVExISEyccHhcgLikxMC4pLSwzOko+MzZGNywtQFdBRkxOUlNSMj5aYVpQYEpRUk//2wBDAQ4ODhMREyYVFSZPNS01T09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0//wAARCAA2AC0DASIAAhEBAxEB/8QAGwAAAgMBAQEAAAAAAAAAAAAABAUAAwYBAgf/xAA0EAACAgADBgMGBAcAAAAAAAABAgMEAAURBhITITFBFCJRBzJhcYGhQlKRsSMzQ1NiwdH/xAAZAQADAQEBAAAAAAAAAAAAAAABAgMEAAX/xAAfEQACAgICAwEAAAAAAAAAAAAAAQIRAyEEMRIiQYH/2gAMAwEAAhEDEQA/ALc2U2Er0VOni5ljY/49T9hg23QNlFzHLEWKynlaM9JVHY/H0wM44mf5YiIzNG7OdB0XdI1ONDWqpShkZ5vIPMzNoABjyuTkcZKuzTBaM8uYBot41bQce8giYkevQdMVNmayIVpQTzTfkELcvnyw2bajIobSxXLEsAkHkaSF1Vh6g6aafHDfSNiCsiGJuauDyKnvhpZskY249gUYt9mPsJAvhGa409p51DAndCfDd7fXDL748ZzNs3d4Ty2DHKzgQ2BGUDHXs5Gh/XAs1s5XYatmL8TkGilX+op/3iuNtesuwS3tB+zgFjNcxnVNeGVgX6DU/vg/arKrV/Zm7WqseOyAqoPvaMCR9QCMU7GKqS5oPxG0T9N0Y0zg9RhVii8jmznLVHxTaG3medyV48zuZcr1KZlVVYqeemsZH9zkPLjX5TQvH2e+Gldo7DwPw95tNAdd0fDljW5i1KpX8XZqxMVYDeZBqCToOZwi2yjhzTZzWex4N13ZV5giTl0+XP7YrmTyJJapix9TCW5M4zXKcoya1YoxQIXEYYlWj3AQOIe2o6euC8wr3KuT5RFfU8bgsfMTqFLagfocMdkaEeWo080glazuCNU5hOeo5d+Q7dMF+0KzCZ6Mcn8xVckD0JGn7HFJPyaOSoc7OwPUyyEtrxpP4shPdjzP/MaaGRpE8y6EYSG1JVQzQQcZl/Bvaa4MqZ9ltqIOLcUTdGjlcKyn0IOMHFuTcr/CuVVoYSBGQpIoZWGhBHIjGcubG5FZJYQGEn8h0AxfdTKLEhdsxQE9SlvT7A45WfLa67sd+JgT1ksBj9zjZbRJCs3dmdl4DFRC2LZOgVDvMW9CewwFDVexNNczNFexOQd0HlGB0UYK2jjpZhWStSmga0ZQ6cPRjqO507YXrmrVSYM2h4FhQNdzzKw9RgKSbr6Fp1YXPVldy9e5NA5Op0OoJ+RxypUeGWWeeczTS6bzaADl8BiYmCopO0gW6oKxMTEwRQRqs6WZJa1pouLpv+UE8vQnpj0lGAFmkUyyN7zyHUnExMDxSdjW6o//2ZAy', renderingMode: UIImageRenderingMode.alwaysOriginal }), UIControlState.normal)
                }.bind(this)
            },
            {
                name: "setAttributedTitle",
                action: function () {
                    var attributedString = new UIAttributedString('Hello!', {
                        [UIAttributedStringKey.foregroundColor]: UIColor.red,
                        [UIAttributedStringKey.underlineStyle]: true,
                    })
                    this.sampleView.setAttributedTitle(attributedString, UIControlState.normal);
                }.bind(this)
            },
            {
                name: "contentEdgeInsets",
                action: function () {
                    this.sampleView.contentEdgeInsets = { top: 12, left: 12, bottom: 0, right: 0 }
                }.bind(this)
            },
            {
                name: "titleEdgeInsets",
                action: function () {
                    this.sampleView.titleEdgeInsets = { top: 12, left: 12, bottom: 0, right: 0 }
                }.bind(this)
            },
            {
                name: "imageEdgeInsets",
                action: function () {
                    this.sampleView.imageEdgeInsets = { top: 12, left: 12, bottom: 0, right: 0 }
                }.bind(this)
            },
            {
                name: "TouchUpInside - Tap",
                action: function () {
                    this.sampleView.accessibilityIdentifier = "Tap Require"
                    this.sampleView.on('touchUpInside', function (sender) {
                        sender.backgroundColor = UIColor.yellow
                        sender.accessibilityIdentifier = "sample view"
                    }.bind(this))
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()
