var main = new UIViewController
main.view.backgroundColor = UIColor.green
main.view.addGestureRecognizer(new UITapGestureRecognizer().on("touch", function(){
                                                               main.view.backgroundColor = UIColor.yellow
                                                               }))
