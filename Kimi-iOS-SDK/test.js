var main = new UIScrollView()
main.frame = { x: 0, y: 0, width: 300, height: 300 }
main.contentSize = { width: 0, height: 1000 }
main.pagingEnabled = true

var subview = new UIView()
subview.backgroundColor = new UIColor(1, 0, 0, 1)
subview.frame = { x: 0, y: 100, width: 44, height: 44 }
main.addSubview(subview)

