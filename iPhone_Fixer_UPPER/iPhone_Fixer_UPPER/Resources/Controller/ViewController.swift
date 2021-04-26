// Last Update: 04/25/2021 06:52PM
// Updated By: Sean Ellis
// Actions: Added background gif to storyboard. Currently loops.
// Next Actions: Need to set the gif to play on background thread for at least 10 seconds while the rest of the app loads. Then set app_ready to true and stop the background_gif from playing.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gif_loadview: UIImageView!
    @IBOutlet weak var loadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLabel.isHidden = true
        loadData(callback: loadComplete)
        loadLabel.isHidden = false
        gif_loadview.loadGif(name: "background_gif_large")
        
    }
    
    func loadData(callback: @escaping () -> Void ) {
        //Load all the necessary user data/iCloud profile
        //Use background thread to load data.
        //Once finished, pass finished = true
        DispatchQueue.global().async {
            sleep(15) //Imitating fetching user data
            DispatchQueue.main.async {
                callback()
            }
        }
    }
    
    func loadComplete() -> Void {
        gif_loadview.stopAnimating()
        gif_loadview.isHidden = true
        loadLabel.isHidden = true
    }

    

}

