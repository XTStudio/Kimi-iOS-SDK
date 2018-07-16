var tests = []

class Cell extends UITableViewCell {

    constructor(context) {
        super(context)
        this.contentView.backgroundColor = UIColor.yellow
        this.on('selected', function (sender, selected) {
            sender.contentView.backgroundColor = selected ? UIColor.red : UIColor.yellow
        })
    }

}

class MainView extends UIView {

    constructor() {
        super()
        this.accessibilityIdentifier = "main view"
        this.sampleView = new UITableView(this.sampleLayout)
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 }
        this.addSubview(this.sampleView)
        this.setupTableView()
        this.setupTests()
    }

    setupTableView() {
        this.sampleView.register(function (context) {
            return new Cell(context)
        }, "Cell")
        this.sampleView.on('numberOfSections', function () {
            return 2
        })
        this.sampleView.on('numberOfRows', function () {
            return 1000
        })
        this.sampleView.on('heightForRow', function () {
            return 44
        })
        this.sampleView.on('cellForRow', function (indexPath) {
            var cell = this.sampleView.dequeueReusableCell("Cell", indexPath)
            if (indexPath.section == 0 && indexPath.row == 0) {
                cell.tag = 1000;
            }
            else {
                cell.tag = 0;
            }
            return cell
        }.bind(this))
    }

    setupTests() {
        tests = [
            {
                name: "DataSource - Wait",
                action: function () {
                    this.sampleView.reloadData()
                }.bind(this)
            },
            {
                name: "selectRow - Tap",
                action: function () {
                    this.sampleView.viewWithTag(1000).accessibilityIdentifier = "Tap Require"
                    this.sampleView.on('didSelectRow', function (_, cell) {
                        cell.accessibilityIdentifier = ""
                    })
                }.bind(this)
            },
            {
                name: "deselectItem - Wait",
                action: function () {
                    this.sampleView.deselectRow(new UIIndexPath(0, 0), false)
                }.bind(this)
            },
            {
                name: "tableHeaderView & tableFooterView - Wait",
                action: function () {
                    var headerView = new UIView
                    headerView.backgroundColor = UIColor.blue
                    headerView.frame = { x: 0, y: 0, width: 0, height: 88 }
                    this.sampleView.tableHeaderView = headerView
                    var footerView = new UIView
                    footerView.backgroundColor = UIColor.green
                    footerView.frame = { x: 0, y: 0, width: 0, height: 88 }
                    this.sampleView.tableFooterView = footerView
                    this.sampleView.reloadData()
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()