var tests = []

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UIImageView()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: (UIScreen.main.bounds.width - 88) / 2.0, y: (UIScreen.main.bounds.height - 88) / 2.0 - 64, width: 88, height: 88 }
        this.addSubview(this.sampleView)
        this.setupTests()
    }

    setupTests() {
        tests = [
            {
                name: "Set Image",
                action: function () {
                    this.sampleView.image = new UIImage({ base64: '/9j/2wBDAA0JCgsKCA0LCgsODg0PEyAVExISEyccHhcgLikxMC4pLSwzOko+MzZGNywtQFdBRkxOUlNSMj5aYVpQYEpRUk//2wBDAQ4ODhMREyYVFSZPNS01T09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0//wAARCAA2AC0DASIAAhEBAxEB/8QAGwAAAgMBAQEAAAAAAAAAAAAABAUAAwYBAgf/xAA0EAACAgADBgMGBAcAAAAAAAABAgMEAAURBhITITFBFCJRBzJhcYGhQlKRsSMzQ1NiwdH/xAAZAQADAQEBAAAAAAAAAAAAAAABAgMEAAX/xAAfEQACAgICAwEAAAAAAAAAAAAAAQIRAyEEMRIiQYH/2gAMAwEAAhEDEQA/ALc2U2Er0VOni5ljY/49T9hg23QNlFzHLEWKynlaM9JVHY/H0wM44mf5YiIzNG7OdB0XdI1ONDWqpShkZ5vIPMzNoABjyuTkcZKuzTBaM8uYBot41bQce8giYkevQdMVNmayIVpQTzTfkELcvnyw2bajIobSxXLEsAkHkaSF1Vh6g6aafHDfSNiCsiGJuauDyKnvhpZskY249gUYt9mPsJAvhGa409p51DAndCfDd7fXDL748ZzNs3d4Ty2DHKzgQ2BGUDHXs5Gh/XAs1s5XYatmL8TkGilX+op/3iuNtesuwS3tB+zgFjNcxnVNeGVgX6DU/vg/arKrV/Zm7WqseOyAqoPvaMCR9QCMU7GKqS5oPxG0T9N0Y0zg9RhVii8jmznLVHxTaG3medyV48zuZcr1KZlVVYqeemsZH9zkPLjX5TQvH2e+Gldo7DwPw95tNAdd0fDljW5i1KpX8XZqxMVYDeZBqCToOZwi2yjhzTZzWex4N13ZV5giTl0+XP7YrmTyJJapix9TCW5M4zXKcoya1YoxQIXEYYlWj3AQOIe2o6euC8wr3KuT5RFfU8bgsfMTqFLagfocMdkaEeWo080glazuCNU5hOeo5d+Q7dMF+0KzCZ6Mcn8xVckD0JGn7HFJPyaOSoc7OwPUyyEtrxpP4shPdjzP/MaaGRpE8y6EYSG1JVQzQQcZl/Bvaa4MqZ9ltqIOLcUTdGjlcKyn0IOMHFuTcr/CuVVoYSBGQpIoZWGhBHIjGcubG5FZJYQGEn8h0AxfdTKLEhdsxQE9SlvT7A45WfLa67sd+JgT1ksBj9zjZbRJCs3dmdl4DFRC2LZOgVDvMW9CewwFDVexNNczNFexOQd0HlGB0UYK2jjpZhWStSmga0ZQ6cPRjqO507YXrmrVSYM2h4FhQNdzzKw9RgKSbr6Fp1YXPVldy9e5NA5Op0OoJ+RxypUeGWWeeczTS6bzaADl8BiYmCopO0gW6oKxMTEwRQRqs6WZJa1pouLpv+UE8vQnpj0lGAFmkUyyN7zyHUnExMDxSdjW6o//2ZAy', renderingMode: UIImageRenderingMode.alwaysOriginal })
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()