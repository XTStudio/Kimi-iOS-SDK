var main = new UIView();
main.frame = { x: 44, y: 44, width: 100, height: 100 };
main.backgroundColor = new UIColor(1, 0, 0, 1);

var s = new UIView()
s.frame = { x: 22, y: 22, width: 44, height: 44 }
s.backgroundColor = new UIColor(1, 1, 0, 1);
main.addSubview(s)

var ss = new UIView()
ss.frame = { x: 44, y: 44, width: 44, height: 44 }
ss.backgroundColor = new UIColor(0, 1, 1, 1)

DispatchQueue.main.asyncAfter(3.0, function() {
    main.addSubview(ss)
})