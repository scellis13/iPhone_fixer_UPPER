import UIKit
import MobileCoreServices

class HomeScreenController: UIViewController {
    //Main View Elements
    @IBOutlet weak var home_screen_image: UIImageView!
    @IBOutlet weak var header_Label: UILabel!
    @IBOutlet weak var fileSelector_Button: UIButton!
    @IBOutlet weak var startScan_Button: UIButton!
    @IBOutlet weak var filename_Label: UILabel!
    @IBOutlet weak var preview_Button: UIButton!
    
    //Helper Elements
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet var showHelp_Outlet: UIView!
    @IBOutlet weak var helpButton_close_Outlet: UIButton!
    @IBOutlet weak var helpContent_Label: UITextView!
    @IBOutlet weak var helpHeader_Label: UILabel!
    @IBOutlet weak var helpFileFormat_Label: UILabel!
    
    var previous_header_text = ""
    var filename = ""
    var fileContent = ""
    var selectedFilePath: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleForMainElements()
        setStyleForHelperElements()
    }
    
    func setStyleForMainElements(){
        filename_Label.text = ""
        
        fileSelector_Button.layer.shadowColor = UIColor.gray.cgColor
        fileSelector_Button.layer.shadowOpacity = 0.75
        fileSelector_Button.layer.shadowOffset = .zero
        fileSelector_Button.layer.shadowRadius = 5.0
        
        startScan_Button.layer.shadowColor = UIColor.gray.cgColor
        startScan_Button.layer.shadowOpacity = 0.75
        startScan_Button.layer.shadowOffset = .zero
        startScan_Button.layer.shadowRadius = 5.0
    }
    
    func setStyleForHelperElements(){
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
        
        setHelpContent()
    }
    
    func setHelpContent(){
        helpContent_Label.text = "This is the guide text to get your started.\n\nHe had three simple rules by which he lived. The first was to never eat blue food. There was nothing in nature that was edible that was blue. People often asked about blueberries, but everyone knows those are actually purple. He understood it was one of the stranger rules to live by, but it had served him well thus far in the 50+ years of his life.\n\n" +
        "Do you think you're living an ordinary life? You are so mistaken it's difficult to even explain. The mere fact that you exist makes you extraordinary. The odds of you existing are less than winning the lottery, but here you are. Are you going to let this extraordinary opportunity pass?\n\n" +
        "It was that terrifying feeling you have as you tightly hold the covers over you with the knowledge that there is something hiding under your bed. You want to look, but you don't at the same time. You're frozen with fear and unable to act. That's where she found herself and she didn't know what to do next" +
            "Do you think you're living an ordinary life? You are so mistaken it's difficult to even explain. The mere fact that you exist makes you extraordinary. The odds of you existing are less than winning the lottery, but here you are. Are you going to let this extraordinary opportunity pass?\n\n" +
            "It was that terrifying feeling you have as you tightly hold the covers over you with the knowledge that there is something hiding under your bed. You want to look, but you don't at the same time. You're frozen with fear and unable to act. That's where she found herself and she didn't know what to do next" +
            "Do you think you're living an ordinary life? You are so mistaken it's difficult to even explain. The mere fact that you exist makes you extraordinary. The odds of you existing are less than winning the lottery, but here you are. Are you going to let this extraordinary opportunity pass?\n\n" +
            "It was that terrifying feeling you have as you tightly hold the covers over you with the knowledge that there is something hiding under your bed. You want to look, but you don't at the same time. You're frozen with fear and unable to act. That's where she found herself and she didn't know what to do next."
    }
    
   
    @IBAction func showHelp_Action(_ sender: Any) {
        animateIn(desiredView: blurView)
        animateIn(desiredView: showHelp_Outlet)
        previous_header_text = header_Label.text!
        header_Label.text = "Getting Started"
    }
    
    @IBAction func helpButton_close(_ sender: Any) {
        animateOut(desiredView: showHelp_Outlet)
        animateOut(desiredView: blurView)
        header_Label.text = previous_header_text
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
    
    
    
    @IBAction func importFiles(_ sender: Any) {

        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePlainText as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func writeFiles(_ sender: Any) {
        print("Writing files.")
        do {
            let newText = fileContent + "\n\nthe Fixer Upper."
            
            let newFileURL = selectedFilePath.deletingLastPathComponent().appendingPathComponent(selectedFilePath.deletingPathExtension().lastPathComponent + "_FIXED").appendingPathExtension("txt")
            
            print("\n\nContent read from: \(selectedFilePath!)")
            try newText.write(to: newFileURL, atomically: false, encoding: .utf8)
            print("\n\nNew Content Written to: \(newFileURL)")
        } catch {
            header_Label.text = "Error: Cannot write new file."
        }
    }
    
    @IBAction func startScan(_ sender: Any){
        header_Label.text = "BegiNNING SCAN..."
        
        
        //Process fileContents
        
        
        
        header_Label.text = "Scan complete."
        preview_Button.isHidden = false
    }
    
    @IBAction func preview_Action(_ sender: Any) {
        
    }
    
    
    
    
}

extension HomeScreenController: UIDocumentPickerDelegate {
    func documentPicker( _ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            return
        }
        //READ TXT FILE
        do {
            selectedFilePath = selectedFileURL
            
            fileContent = try String(contentsOf: selectedFileURL, encoding: .utf8)
            //print(fileContent)
            header_Label.text = "Imported file successful.\nScan ready."
            filename_Label.text = selectedFilePath.deletingLastPathComponent().lastPathComponent + "/" + selectedFilePath.lastPathComponent
            startScan_Button.isHidden = false
        } catch {
            header_Label.text = "Error: Import failed."
        }
        
    }
}
