var main = new UINavigationBarViewController
main.navigationBar.backgroundColor = UIColor.yellow
main.view.backgroundColor = UIColor.green

main.view.addGestureRecognizer(new UITapGestureRecognizer().on("touch", function(){
                                                               main.navigationController.pushViewController(new UIViewController())
                                                               }))
