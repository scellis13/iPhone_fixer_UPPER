// Last Update: 04/25/2021 06:52PM
// Updated By: Sean Ellis
// Actions: Added background gif to storyboard. Currently loops.
// Next Actions: Need to set the gif to play on background thread for at least 10 seconds while the rest of the app loads. Then set app_ready to true and stop the background_gif from playing.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gif_loadview: UIImageView!
    @IBOutlet weak var loadLabel: UILabel!
    @IBOutlet weak var background_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLabel.isHidden = true
        background_image.isHidden = true
        loadData(callback: loadComplete)
        gif_loadview.loadGif(name: "background_gif_large")
        loadLabel.isHidden = false
        
    }
    
    func loadData(callback: @escaping () -> Void ) {
        //Load all the necessary user data/iCloud profile
        //Use background thread to load data.
        //Once finished, pass finished = true
        DispatchQueue.global().async {
            sleep(15) //Imitating fetching user data
            DispatchQueue.main.async {
                self.gif_loadview.isHidden = true
                self.background_image.isHidden = false
                self.loadLabel.text = "Load complete."
            }
            sleep(3)
            DispatchQueue.main.async {
                callback()
            }
        }
    }
    
    func loadComplete() -> Void {
        //Change views here.
        loadLabel.isHidden = true
    }

    

}

