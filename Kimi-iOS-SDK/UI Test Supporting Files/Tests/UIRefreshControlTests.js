
var tests = []

class MainView extends UIView {
    
    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UIScrollView()
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 }
        var refreshControl = new UIRefreshControl
        refreshControl.on('refresh', function(sender){
                          DispatchQueue.main.asyncAfter(3.0, function(){
                                                        sender.endRefreshing()
                                                        })
                          })
        this.sampleView.addSubview(refreshControl)
        this.setupSubviews()
        this.addSubview(this.sampleView)
    }
    
    setupSubviews() {
        for (var index = 0; index < 100; index++) {
            var subview = new UIView
            subview.frame = { x: 0, y: index * 88, width: 44, height: 44 }
            subview.backgroundColor = new UIColor(1, 0, 0, 1.0 / index)
            this.sampleView.addSubview(subview)
        }
        this.sampleView.contentSize = {width:0, height: 88 * 100}
    }
    
}

var main = new MainView()
