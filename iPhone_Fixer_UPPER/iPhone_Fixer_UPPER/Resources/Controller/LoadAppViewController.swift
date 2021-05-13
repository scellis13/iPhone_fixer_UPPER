// Last Update: 04/25/2021 08:53PM
// Updated By: Sean Ellis
// Actions: Added Background Queue that is simulating user data load. Will have to assess how long it takes to load iCloud Drive and user data later, but for now it simulates a 15 second load time. Swaps to a background still view once load is complete.
// Next Actions: Design initial view that prompts user to add text/file to be converted.

import UIKit

class LoadAppViewController: UIViewController {

    @IBOutlet weak var loadHomeViewButton: UIButton!
    @IBOutlet weak var gif_loadview: UIImageView!
    @IBOutlet weak var loadLabel: UILabel!
    @IBOutlet weak var background_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLabel.isHidden = true
        background_image.isHidden = true
        loadHomeViewButton.layer.borderColor = UIColor.gray.cgColor
        loadHomeViewButton.layer.borderWidth = 1.0
        loadHomeViewButton.layer.cornerRadius = 15.0
        loadHomeViewButton.layer.shadowColor = UIColor.gray.cgColor
        loadHomeViewButton.layer.shadowOpacity = 0.75
        loadHomeViewButton.layer.shadowOffset = .zero
        loadData(callback: loadComplete)
        gif_loadview.loadGif(name: "background_gif_large")
        loadLabel.isHidden = false
        
    }

    
    func loadData(callback: @escaping () -> Void ) {
        //Load all the necessary user data/iCloud profile
        //Use background thread to load data.
        //Once finished, pass finished = true
        DispatchQueue.global().async {
            sleep(1) //Imitating fetching user data
            DispatchQueue.main.async {
                self.gif_loadview.isHidden = true
                self.background_image.isHidden = false
                self.loadLabel.text = "Load complete."
            }
            sleep(1)
            DispatchQueue.main.async {
                callback()
            }
        }
    }
    
    func loadComplete() -> Void {
        //Change views here.
        loadLabel.isHidden = true
        //Swap Views to HomeScreenView
        loadHomeViewButton.isHidden = false
    }
    
    
}

