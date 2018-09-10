var main = new UIViewController
main.view.backgroundColor = UIColor.green
main.view.addGestureRecognizer(new UITapGestureRecognizer().on("touch", function(){
                                                               
                                                               var actionSheet = new UIActionSheet
                                                               actionSheet.addRegularAction('a', function() {
                                                                                          console.log('a')
                                                                                          });
                                                               actionSheet.addDangerAction('b', function() {
                                                                                          console.log('b')
                                                                                          });
                                                               actionSheet.addCancelAction('cancel', function() {
                                                                                          main.view.backgroundColor = UIColor.yellow
                                                                                          });
                                                               actionSheet.show()
                                                               }))
