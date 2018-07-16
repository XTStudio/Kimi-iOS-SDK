var tests = []

class TestViewController extends UIPageViewController {

    constructor(rootViewController) {
        super(rootViewController)
        this.setupTests()
    }

    setupTests() {
        tests = [
            {
                name: "setPageItems & loops",
                action: function () {
                    var a = new UIViewController
                    a.title = "Yellow"
                    a.view.backgroundColor = UIColor.yellow
                    var b = new UIViewController
                    b.title = "Red"
                    b.view.backgroundColor = UIColor.red
                    var c = new UIViewController
                    c.title = "Gray"
                    c.view.backgroundColor = UIColor.gray
                    this.pageItems = [a, b, c]
                    this.loops = true
                }.bind(this)
            },
            {
                name: "scrollToNextPage - Wait",
                action: function () {
                    this.scrollToNextPage(true)
                }.bind(this)
            },
            {
                name: "scrollToPreviousPage - Wait",
                action: function () {
                    this.scrollToPreviousPage(true)
                }.bind(this)
            },
            {
                name: "Loops - Wait",
                action: function () {
                    this.scrollToNextPage(false)
                    this.scrollToNextPage(false)
                    this.scrollToNextPage(false)
                }.bind(this)
            },
            {
                name: "dataSource - Wait",
                action: function () {
                    this.pageItems = undefined
                    this.loops = false
                    var a = new UIViewController
                    a.title = "Red"
                    a.view.backgroundColor = UIColor.red
                    this.currentPage = a
                    this.on('beforeViewController', function (currentPage) {
                        if (currentPage.title === "Red") {
                            var b = new UIViewController
                            b.title = "Yellow"
                            b.view.backgroundColor = UIColor.yellow
                            return b
                        }
                    })
                    this.on('afterViewController', function (currentPage) {
                        if (currentPage.title === "Yellow") {
                            return a
                        }
                        if (currentPage.title === "Red") {
                            var c = new UIViewController
                            c.title = "Blue"
                            c.view.backgroundColor = UIColor.blue
                            return c
                        }
                    })
                    this.scrollToPreviousPage(false)
                }.bind(this)
            },
            {
                name: "dataSource2 - Wait",
                action: function () {
                    this.scrollToNextPage(false)
                    this.scrollToNextPage(false)
                }.bind(this)
            },
        ]
    }

}

var main = new TestViewController()
