var FooCell = /** @class */ (function (_super) {
    __extends(FooCell, _super);
    function FooCell() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    return FooCell;
}(UICollectionViewCell));

var layout = new UICollectionViewFlowLayout
var main = new UICollectionView(layout)
main.frame = { x: 0, y: 0, width: 375, height: 500 }
main.register(function (context) {
    var cell = new FooCell(context)
    cell.backgroundColor = new UIColor(1, 1, 0, 1)
    cell.on('selected', function (sender, selected, animated) {
        new UIConfirm("Destory earth.").show(function() {
            sender.backgroundColor = !selected ? new UIColor(1, 1, 0, 1) : new UIColor(1, 1, 1, 1)
        })
        // if (animated) {
        //     UIAnimator.shared.linear(0.3, function () {
        //         sender.backgroundColor = !selected ? new UIColor(1, 1, 0, 1) : new UIColor(1, 1, 1, 1)
        //     })
        // }
        // else {
        //     sender.backgroundColor = !selected ? new UIColor(1, 1, 0, 1) : new UIColor(1, 1, 1, 1)
        // }
    })
    return cell
}, "Cell")
main.allowsMultipleSelection = true
main.on('numberOfSections', function () { return 1 })
main.on('numberOfItems', function () { return 10000 })
main.on('cellForItem', function (indexPath) {
    return main.dequeueReusableCell("Cell", indexPath);
});
layout.minimumLineSpacing = 44
layout.on('sizeForItem', function () {
    return { width: 100, height: 100 }
});
layout.on('insetForSection', function () {
    return { left: 20, right: 20 }
})
// main.on('didSelectRow', function (indexPath) {
//     main.deselectRow(indexPath, true)
// })
// main.on('viewForHeader', function (section) {
//     var view = new UIView()
//     view.backgroundColor = new UIColor(1, 1, 0, 1)
//     return view
// });
// main.on('heightForHeader', function (section) {
//     return 22
// });
main.reloadData()

// var subview = new UIView()
// subview.backgroundColor = new UIColor(1, 0, 0, 1)
// subview.frame = { x: 0, y: 100, width: 44, height: 44 }
// main.addSubview(subview)

