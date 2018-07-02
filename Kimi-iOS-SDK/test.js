var main = new UILabel
main.frame = { x: 16, y: 16, width: 400, height: 44 }

var str = new UIAttributedString("Hello, World!", {
    [UIForegroundColorAttributeName]: new UIColor(1, 0, 0, 1),
    [UIFontAttributeName]: new UIFont(28),
}).mutable();

str.setAttributes({
    [UIForegroundColorAttributeName]: new UIColor(1, 0, 1, 1),
}, { location: 1, length: 2 });

str.addAttribute(UIFontAttributeName, new UIFont(42), { location: 1, length: 1 })
str.addAttributes({ [UIFontAttributeName]: new UIFont(42) }, { location: 2, length: 3 })
str.removeAttribute(UIFontAttributeName, { location: 2, length: 1 })
str.replaceCharactersWithAttributedString({ location: 2, length: 1 }, new UIAttributedString("UUU"))
str.insertAttributedString(new UIAttributedString("GGG"), 0)
str.appendAttributedString(new UIAttributedString("UIO", { [UIForegroundColorAttributeName]: new UIColor(1, 1, 1, 0) }))
str.deleteCharacters({ location: 0, length: 4 })
str.replaceCharacters({ location: 0, length: 1 }, "P")

main.attributedText = str.immutable();