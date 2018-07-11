class MyViewController extends UIViewController {

    viewDidLoad() {
        super.viewDidLoad()
        var layer = new CAShapeLayer
        layer.strokeColor = UIColor.black
        layer.lineWidth = 4
        layer.frame = { x: 0, y: 0, width: 300, height: 300 }
        var path = new UIBezierPath
        path.moveTo({ x: 100, y: 100 })
        path.addLineTo({ x: 200, y: 100 })
        path.addLineTo({ x: 200, y: 200 })
        path.closePath()
        layer.path = path
        this.view.layer.addSublayer(layer)
    }

}

main = new MyViewController()