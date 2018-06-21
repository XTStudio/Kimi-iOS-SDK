var main = new UIView();
main.frame = { x: 44, y: 44, width: 100, height: 100 };
main.backgroundColor = new UIColor(1, 0, 0, 1);

var sublayer = new CALayer();
sublayer.frame = { x: 22, y: 22, width: 44, height: 44 }
sublayer.backgroundColor = new UIColor(1, 1, 0, 1);
sublayer.cornerRadius = 6
sublayer.borderWidth = 4
sublayer.borderColor = new UIColor(0.5, 0.5, 1, 1);
main.layer.addSublayer(sublayer)