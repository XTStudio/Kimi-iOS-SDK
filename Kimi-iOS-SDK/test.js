var main = new UIView();
main.frame = { x: 44, y: 44, width: 100, height: 100 };
main.backgroundColor = new UIColor(1, 0, 0, 1);

var longPressGesture = new UILongPressGestureRecognizer()
longPressGesture.on('began', function (sender) {
    if (sender.state == UIGestureRecognizerState.began) {
        main.backgroundColor = new UIColor(1, Math.random(), 0, 1);
    }
})
main.addGestureRecognizer(longPressGesture)