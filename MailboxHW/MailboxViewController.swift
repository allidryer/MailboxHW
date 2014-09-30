//
//  MailboxViewController.swift
//  MailboxHW
//
//  Created by Alli Dryer on 9/28/14.
//  Copyright (c) 2014 Alli Dryer. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var bigContainerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navBgImageView: UIImageView!
    @IBOutlet weak var navSegmentedControl: UISegmentedControl!
    @IBOutlet weak var helpLabelImageView: UIImageView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var smallContainerView: UIView!
    @IBOutlet weak var laterIconImageView: UIImageView!
    @IBOutlet weak var archiveIconImageView: UIImageView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var rescheduleImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    
    var imageCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        bigContainerView.addGestureRecognizer(edgeGesture)
        
        var scrollWidth: CGFloat  = self.view.frame.width
        var scrollHeight: CGFloat  = self.view.frame.size.height
        self.scrollView!.contentSize = CGSizeMake(scrollWidth, scrollHeight + 864);

        scrollView.delegate = self
        
        rescheduleImageView.alpha = 0
        listImageView.alpha = 0
    }

    @IBAction func onPanMessage(gestureRecognizer: UIPanGestureRecognizer) {
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            self.archiveIconImageView.alpha = 0.3
            self.laterIconImageView.alpha = 0.3
            UIView.animateWithDuration(0.3, delay: 0.2, options: nil, animations: {
                self.laterIconImageView.alpha = 1
                self.archiveIconImageView.alpha = 1
            }, completion: nil)
            imageCenter = messageImageView.center
            smallContainerView.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
            
        }  else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            laterIconImageView.image = UIImage(named: "later_icon.png")
            archiveIconImageView.image = UIImage(named: "archive_icon.png")
            laterIconImageView.alpha = 0.3
            archiveIconImageView.alpha = 0.3
            messageImageView.center.x = translation.x + imageCenter.x
            
                // gray section
                if messageImageView.center.x >= 100 && messageImageView.center.x < 160 {
                    self.laterIconImageView.alpha = 1
                    self.archiveIconImageView.alpha = 0
                    smallContainerView.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
                } else if messageImageView.center.x >= 160 && messageImageView.center.x < 220 {
                    self.laterIconImageView.alpha = 0
                    self.archiveIconImageView.alpha = 1
                    smallContainerView.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
                
                // yellow or green section
                } else if messageImageView.center.x < 100 && messageImageView.center.x > -100 {
                    self.laterIconImageView.alpha = 1
                    self.archiveIconImageView.alpha = 0
                    smallContainerView.backgroundColor = UIColor(red: 255/255, green: 211/255, blue: 32/255, alpha: 1)
                    laterIconImageView.center.x = messageImageView.center.x + 190
                } else if messageImageView.center.x >= 220 && messageImageView.center.x < 420 {
                    self.laterIconImageView.alpha = 0
                    self.archiveIconImageView.alpha = 1
                    smallContainerView.backgroundColor = UIColor(red: 98/255, green: 217/255, blue: 98/255, alpha: 1)
                    archiveIconImageView.center.x = messageImageView.center.x - 190
                    
                // brown or red section
                } else if messageImageView.center.x <= -100 {
                    self.laterIconImageView.alpha = 1
                    self.archiveIconImageView.alpha = 0
                    smallContainerView.backgroundColor = UIColor(red: 216/255, green: 176/255, blue: 117/255, alpha: 1)
                    laterIconImageView.image = UIImage(named: "list_icon.png")
                    laterIconImageView.center.x = messageImageView.center.x + 190
                } else if messageImageView.center.x >= 420 {
                    self.laterIconImageView.alpha = 0
                    self.archiveIconImageView.alpha = 1
                    smallContainerView.backgroundColor = UIColor(red: 239/255, green: 84/255, blue: 12/255, alpha: 1)
                    archiveIconImageView.image = UIImage(named: "delete_icon.png")
                    archiveIconImageView.center.x = messageImageView.center.x - 190
                }
            
        }  else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            //gray section
            if messageImageView.center.x >= 100 && messageImageView.center.x < 160 {
                //Alpha formula: abs(Position - minimum position)/ (max - min)
                self.laterIconImageView.alpha = abs(messageImageView.center.x - 160)/60
                self.archiveIconImageView.alpha = 0
                smallContainerView.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
                
            } else if messageImageView.center.x >= 160 && messageImageView.center.x < 220 {
                self.laterIconImageView.alpha = 0
                //Alpha formula: (Position - minimum position)/ (max - min)
                self.archiveIconImageView.alpha = (messageImageView.center.x-160)/60
                smallContainerView.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
                
            //yellow section
            } else if messageImageView.center.x < 100 && messageImageView.center.x > -100 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.laterIconImageView.alpha = 0
                    self.messageImageView.center.x = -160
                    self.laterIconImageView.center.x = self.messageImageView.center.x + 190
                    }, completion: { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.rescheduleImageView.alpha = 1
                        }, completion: nil)
                })
            //green section
            } else if messageImageView.center.x >= 220 && messageImageView.center.x < 420 {
                UIView.animateWithDuration(0.3, animations: {
                    self.archiveIconImageView.alpha = 0
                    self.messageImageView.center.x = 480
                    self.archiveIconImageView.center.x = self.messageImageView.center.x - 190
                    }) { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.feedImageView.transform = CGAffineTransformMakeTranslation(0, -86)
                            }, completion: { (finished: Bool) -> Void in
                                self.messageImageView.center.x = 160
                                self.laterIconImageView.center.x = 290
                                self.archiveIconImageView.center.x = 32
                                self.feedImageView.transform = CGAffineTransformMakeTranslation(0, 0)
                            })
                }
            // brown section
            } else if messageImageView.center.x <= -100 {
                UIView.animateWithDuration(0.3, animations: {
                    self.laterIconImageView.alpha = 0
                    self.archiveIconImageView.alpha = 0
                    self.messageImageView.center.x = -160
                    self.laterIconImageView.center.x = self.messageImageView.center.x + 190
                    }, completion: { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.listImageView.alpha = 1
                            }, completion: nil)
                })
            // red section
            } else if messageImageView.center.x >= 420 {
                UIView.animateWithDuration(0.3, animations: {
                    self.archiveIconImageView.alpha = 0
                    self.laterIconImageView.alpha = 0
                    self.messageImageView.center.x = 480
                    self.archiveIconImageView.center.x = self.messageImageView.center.x - 190
                    }) { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.feedImageView.transform = CGAffineTransformMakeTranslation(0, -86)
                            }, completion: { (finished: Bool) -> Void in
                                self.messageImageView.center.x = 160
                                self.feedImageView.transform = CGAffineTransformMakeTranslation(0, 0)
                                self.laterIconImageView.center.x = 290
                                self.archiveIconImageView.center.x = 32
                        })
                }
            }
        }
    }

    @IBAction func onRescheduleTap(sender: UITapGestureRecognizer) {
       UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.rescheduleImageView.alpha = 0
            }) { (finished: Bool) -> Void in
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.feedImageView.transform = CGAffineTransformMakeTranslation(0, -86)
                }, completion: { (finished: Bool) -> Void in
                    self.messageImageView.center.x = 160
                    self.feedImageView.transform = CGAffineTransformMakeTranslation(0, 0)
                    self.laterIconImageView.center.x = 290
                    self.archiveIconImageView.center.x = 32
                    })
                }
    }
    
    @IBAction func onListTap(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.listImageView.alpha = 0
            }) { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.feedImageView.transform = CGAffineTransformMakeTranslation(0, -86)
                    }, completion: { (finished: Bool) -> Void in
                        self.messageImageView.center.x = 160
                        self.feedImageView.transform = CGAffineTransformMakeTranslation(0, 0)
                        self.laterIconImageView.center.x = 290
                        self.archiveIconImageView.center.x = 32
                })
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanBigContainerView(panGestureRecognizer: UIPanGestureRecognizer) {
        var location = panGestureRecognizer.locationInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            imageCenter = bigContainerView.center
//            if bigContainerView.frame.origin.x == 0 && translation.x < 0 {
//            panGestureRecognizer.enabled = false
//            } 
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            if translation.x > 0 {
                bigContainerView.center.x = translation.x + imageCenter.x
            } else if translation.x < 0 {
                bigContainerView.center.x = translation.x + imageCenter.x
            }
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            if translation.x > 160 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.bigContainerView.frame.origin.x = 290
                    }, completion: nil)
            } else if translation.x < 160 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.bigContainerView.frame.origin.x = 0
                }, completion: nil)
            }
            
        }

    }
    
    func onEdgePan(edgeGesture: UIScreenEdgePanGestureRecognizer) {
        var location = edgeGesture.locationInView(view)
        var translation = edgeGesture.translationInView(view)
        var velocity = edgeGesture.velocityInView(view)
        
        if edgeGesture.state == UIGestureRecognizerState.Began {
            imageCenter = bigContainerView.center
            bigContainerView.center.x = translation.x + imageCenter.x
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer!, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer!) -> Bool {
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
