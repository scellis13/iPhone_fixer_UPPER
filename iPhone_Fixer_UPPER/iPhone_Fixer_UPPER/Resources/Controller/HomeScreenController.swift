import UIKit

class HomeScreenController: UIViewController {
    @IBOutlet weak var home_screen_image: UIImageView!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet var showHelp_Outlet: UIView!
    @IBOutlet weak var helpButton_close_Outlet: UIButton!
    @IBOutlet weak var helpContent_Label: UILabel!
    @IBOutlet weak var helpHeader_Label: UILabel!
    @IBOutlet weak var helpFileFormat_Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.bounds = self.view.bounds;
        showHelp_Outlet.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.75)
        showHelp_Outlet.layer.shadowColor = UIColor.gray.cgColor
        showHelp_Outlet.layer.shadowOpacity = 1
        showHelp_Outlet.layer.shadowOffset = .zero
        showHelp_Outlet.layer.shadowRadius = 10.0
        
        helpHeader_Label.layer.shadowColor = UIColor.gray.cgColor
        helpHeader_Label.layer.shadowOpacity = 0.75
        helpHeader_Label.layer.shadowOffset = .zero
        helpHeader_Label.layer.shadowRadius = 5.0
        
        helpHeader_Label.layer.borderColor = UIColor.gray.cgColor
        helpFileFormat_Label.layer.borderColor = UIColor.gray.cgColor
        helpHeader_Label.layer.borderWidth = 1.0
        helpFileFormat_Label.layer.borderWidth = 1.0
        helpHeader_Label.layer.cornerRadius = 5.0
        helpFileFormat_Label.layer.cornerRadius = 5.0
    }
    
    
    
    @IBAction func showHelp_Action(_ sender: Any) {
        animateIn(desiredView: blurView)
        animateIn(desiredView: showHelp_Outlet)
    }
    
    @IBAction func helpButton_close(_ sender: Any) {
        animateOut(desiredView: showHelp_Outlet)
        animateOut(desiredView: blurView)
    }
    
    func animateIn(desiredView: UIView) {
        let backgroundView = self.view!
        backgroundView.addSubview(desiredView);
        
        //Sets the View's Scaling to be 120%
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center
        desiredView.layer.cornerRadius = 10.0
        
        //animates view passed in
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        })
    }
    
    func animateOut(desiredView: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        }, completion: { _ in
            desiredView.removeFromSuperview()
        })
        
    }
}
