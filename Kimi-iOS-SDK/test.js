var main = new UIView();
main.frame = { x: 44, y: 44, width: 100, height: 100 };
main.backgroundColor = new UIColor(1, 0, 0, 1);

main.addGestureRecognizer(new UITapGestureRecognizer().on('touch', function () {
    main.backgroundColor = new UIColor(1, Math.random(), 0, 1);
}))

DispatchQueue.main.asyncAfter(3.0, function() {
    main.removeFromSuperview()
    main = undefined
})