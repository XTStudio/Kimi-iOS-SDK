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

main.addSubview(ss)

DispatchQueue.main.asyncAfter(1.0, function () {
    UIAnimator.shared.spring(70.0, 4.0, function () {
        main.transform = { a: 1.5, b: 0, c: 0, d: 1.5, tx: 44, ty: 44 }
        // main.backgroundColor = new UIColor(1, 0.5, 0, 1)
    })
})