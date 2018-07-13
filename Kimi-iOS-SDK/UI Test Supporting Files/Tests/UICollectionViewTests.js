var tests = []

class Cell extends UICollectionViewCell {

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
        this.sampleLayout = new UICollectionViewFlowLayout()
        this.sampleView = new UICollectionView(this.sampleLayout)
        this.sampleView.accessibilityIdentifier = "sample view"
        this.sampleView.frame = { x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 }
        this.addSubview(this.sampleView)
        this.setupCollectionView()
        this.setupTests()
    }

    setupCollectionView() {
        this.sampleLayout.itemSize = { width: 44, height: 44 }
        this.sampleLayout.minimumLineSpacing = 2
        this.sampleLayout.minimumInteritemSpacing = 2
        this.sampleLayout.sectionInset = { top: 6, left: 6, bottom: 6, right: 6 }
        this.sampleLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        this.sampleView.register(function (context) {
            return new Cell(context)
        }, "Cell")
        this.sampleView.on('numberOfSections', function () {
            return 2
        })
        this.sampleView.on('numberOfItems', function () {
            return 2
        })
        this.sampleView.on('cellForItem', function (indexPath) {
            let cell = this.sampleView.dequeueReusableCell("Cell", indexPath)
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
                name: "selectItem - Tap",
                action: function () {
                    this.sampleView.viewWithTag(1000).accessibilityIdentifier = "Tap Require"
                    this.sampleView.on('didSelectItem', function (_, cell) {
                        cell.accessibilityIdentifier = ""
                    })
                }.bind(this)
            },
            {
                name: "deselectItem - Wait",
                action: function () {
                    this.sampleView.deselectItem(new UIIndexPath(0, 0), false)
                }.bind(this)
            },
        ]
    }

}

var main = new MainView()