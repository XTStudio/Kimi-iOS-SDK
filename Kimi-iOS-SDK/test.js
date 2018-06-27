var FooCell = /** @class */ (function (_super) {
    __extends(FooCell, _super);
    function FooCell() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    return FooCell;
}(UITableViewCell));

var main = new UITableView()
main.frame = { x: 0, y: 0, width: 300, height: 300 }
main.register(function (context) { return new FooCell(context) }, "Cell")
main.on('numberOfSections', function () { return 1 })
main.on('numberOfRows', function () { return 20 })
main.on('cellForRow', function (indexPath) {
    var cell = main.dequeueReusableCell("Cell", indexPath);
    cell.backgroundColor = new UIColor(1, 1, 0, 1)
    return cell
});
main.on('heightForRow', function () {
    return 66
});
main.on('didSelectRow', function (indexPath) {
    main.deselectRow(indexPath, true)
})
main.reloadData()


// var subview = new UIView()
// subview.backgroundColor = new UIColor(1, 0, 0, 1)
// subview.frame = { x: 0, y: 100, width: 44, height: 44 }
// main.addSubview(subview)

