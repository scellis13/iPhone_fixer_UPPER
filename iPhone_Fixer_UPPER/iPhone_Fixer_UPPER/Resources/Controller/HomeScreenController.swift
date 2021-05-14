import UIKit
import MobileCoreServices
import Foundation

class HomeScreenController: UIViewController {
    
    //Main View Elements
    @IBOutlet weak var background_home: UIImageView!
    @IBOutlet weak var home_screen_image: UIImageView!
    @IBOutlet weak var header_Label: UILabel!
    @IBOutlet weak var fileSelector_Button: UIButton!
    @IBOutlet weak var startScan_Button: UIButton!
    @IBOutlet weak var filename_Label: UILabel!
    @IBOutlet weak var preview_Button: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var completed_Label: UITextView!
    @IBOutlet weak var completed_Image: UIImageView!
    @IBOutlet weak var reset_Button: UIButton!
    
    //Preview Elements
    @IBOutlet var previewScanView: UIView!
    @IBOutlet weak var previewExitButton: UIButton!
    @IBOutlet weak var previewHeader_New: UILabel!
    @IBOutlet weak var previewContentView_Old: UITextView!
    @IBOutlet weak var previewHeader_Old: UILabel!
    @IBOutlet weak var previewContentView_New: UITextView!
    
    
    //Helper Elements
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet var showHelp_Outlet: UIView!
    @IBOutlet weak var helpButton_close_Outlet: UIButton!
    @IBOutlet weak var helpContent_Label: UITextView!
    @IBOutlet weak var helpHeader_Label: UILabel!
    @IBOutlet weak var helpFileFormat_Label: UILabel!
    @IBOutlet weak var comingSoon: UILabel!
    
    var previous_header_text = ""
    var filename = ""
    var fileContent = ""
    var newText = ""
    var selectedFilePath: URL!
    var newFileURL: URL!
    var pathExtension = ""
    
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
        
        fileSelector_Button.layer.borderColor = UIColor.gray.cgColor
        fileSelector_Button.layer.borderWidth = 1.0
        fileSelector_Button.layer.cornerRadius = 15.0
        
        startScan_Button.layer.borderColor = UIColor.gray.cgColor
        startScan_Button.layer.borderWidth = 1.0
        startScan_Button.layer.cornerRadius = 15.0
    }
    
    func setStyleForHelperElements(){
        blurView.bounds = self.view.bounds;
        showHelp_Outlet.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.75)
        showHelp_Outlet.layer.shadowColor = UIColor.gray.cgColor
        showHelp_Outlet.layer.shadowOpacity = 1
        showHelp_Outlet.layer.shadowOffset = .zero
        showHelp_Outlet.layer.shadowRadius = 10.0
        
        
        helpHeader_Label.layer.borderColor = UIColor.gray.cgColor
        helpFileFormat_Label.layer.borderColor = UIColor.gray.cgColor
        helpHeader_Label.layer.borderWidth = 1.0
        helpFileFormat_Label.layer.borderWidth = 1.0
        helpHeader_Label.layer.cornerRadius = 5.0
        helpFileFormat_Label.layer.cornerRadius = 5.0
        comingSoon.text = "Coming\nSoon"
        setHelpContent()
    }
    
    func setStyleForPreviewElements() {
        previewScanView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.75)
        previewScanView.layer.shadowColor = UIColor.gray.cgColor
        previewScanView.layer.shadowOpacity = 1
        previewScanView.layer.shadowOffset = .zero
        previewScanView.layer.shadowRadius = 10.0
        
        previewHeader_New.layer.borderColor = UIColor.gray.cgColor
        previewHeader_Old.layer.borderColor = UIColor.gray.cgColor
        previewHeader_New.layer.borderWidth = 1.0
        previewHeader_Old.layer.borderWidth = 1.0
        previewHeader_New.layer.cornerRadius = 5.0
        previewHeader_Old.layer.cornerRadius = 5.0
    }
    
    func setHelpContent(){

        helpContent_Label.text = "This is the guide text to get your started.\n\nStart by clicking Import File when you are ready to fix a document. You will be prompted to choose a document from your iCloud. You will be able to make changes to any local files accesed from your iOS Device. It is essential that you have stored it in the correct place. \n\n" +
        "Once your Document folder is selected, click on the file that needs fixing. Once the file is imported there will be a message at the top of your screen saying 'Imported file successful. Scan Ready.' Your next step is to click Scan and Fix located directly under the Import File button. The app will convert all uppercase letters to lowercase, except the first letter after a period.\n\n" +
        "From here you can click on the Preview button to see your old document compared to the new fixed document. This is optional, it serves as a check to make sure you are happy with the changes. Once you are ready to continue, you can click the exit button located at the top right of the screen." +
            "Your last step is to save. You can do this by using the Save button located to the right of the Preview button. Once you have saved your new file, it will save to the location you originally pulled your document from. It will be renamed with the original files name that also includes a current timestamp. For example, a file named 'textfile.txt' will be renamed to: 'textfile Fixed yyyy-MM-dd HH:mm:ss.txt'."
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
        
        preview_Button.isHidden = true
        saveButton.isHidden = true
        
    }
    
    
    @IBAction func startScan(_ sender: Any){
        header_Label.text = "BegiNNING SCAN..."
        saveButton.isHidden = true
        preview_Button.isHidden = true
        
        
        
        //Process fileContents
        var sentences: [String] = []
        var tempText = ""
        var delimiter = ". "
        sentences = fileContent.lowercased().components(separatedBy: delimiter)
        
        for sentence in sentences {
            let sentenceChange = sentence.capitalizingFirstLetter()
            
            tempText += "\(sentenceChange). "
        }
        
        delimiter = "\n"
        sentences = tempText.components(separatedBy: delimiter)
        for sentence in sentences {
            let sentenceChange = sentence.capitalizingFirstLetter()
            newText += "\(sentenceChange)\n"
        }
        
        
        header_Label.text = "Scan complete. Choose Preview, Save or Import to continue."
        preview_Button.isHidden = false
        saveButton.isHidden = false
        startScan_Button.isHidden = true
    }
    
    @IBAction func preview_Action(_ sender: Any) {
        previewContentView_New.text = newText
        previewContentView_Old.text = fileContent
        animateIn(desiredView: blurView)
        animateIn(desiredView: previewScanView)
        previous_header_text = header_Label.text!
        previewHeader_New.text = selectedFilePath.deletingLastPathComponent().appendingPathComponent(selectedFilePath.deletingPathExtension().lastPathComponent + "_FIXED").appendingPathExtension("txt").lastPathComponent
        previewHeader_Old.text = selectedFilePath.lastPathComponent
        header_Label.text = "Previewing changes made."
    }
    
    @IBAction func previewExitButton_close(_ sender: Any) {
        animateOut(desiredView: previewScanView)
        animateOut(desiredView: blurView)
        header_Label.text = previous_header_text
    }
    
    @IBAction func saveFile(_ sender: Any) {
        print("Writing files.")
        do {
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = Date()
            let dateString = dateFormatter.string(from:date)
            
            newFileURL = selectedFilePath.deletingLastPathComponent().appendingPathComponent(selectedFilePath.deletingPathExtension().lastPathComponent + " Fixed " + dateString).appendingPathExtension("txt")
            
            print("\n\nContent read from: \(selectedFilePath.absoluteURL)")
            try newText.write(to: newFileURL, atomically: false, encoding: .utf8)
            print("\n\nNew Content Written to: \(newFileURL.absoluteURL)")
            
            header_Label.text = "Save complete."
            
            saveButton.isHidden = true
            preview_Button.isHidden = true
            filename_Label.isHidden = true
            fileSelector_Button.isHidden = true
            background_home.isHidden = true
            completed_Label.isHidden = false
            completed_Image.isHidden = false
            helpButton.isHidden = true
            header_Label.isHidden = true
            reset_Button.isHidden = false
            completed_Label.text = "Thank you for choosing the Fixer UPPER.\nWe hope you enjoyed our Application!\n\nYour new file '\(newFileURL.lastPathComponent)' has been saved to the original folder location chosen."
        } catch {
            header_Label.text = "Error: Cannot write new file."
        }
    }
    
    
    @IBAction func resetAction(_ sender: Any) {
        reset_Button.isHidden = true
        completed_Label.isHidden = true
        completed_Image.isHidden = true
        previous_header_text = ""
        filename = ""
        fileContent = ""
        newText = ""
        header_Label.text = "Select a File to Begin."
        filename_Label.text = ""
        fileSelector_Button.isHidden = false
        background_home.isHidden = false
        helpButton.isHidden = false
        header_Label.isHidden = false
        filename_Label.isHidden = false
    }
    
    
}
extension HomeScreenController: UIDocumentPickerDelegate {
    func documentPicker( _ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            return
        }
        //READ FILE
        do {
            selectedFilePath = selectedFileURL
            print("\n\nAbsolute URL String: " + selectedFilePath.absoluteString + "\n\n")
            
            //print(fileContent)
            header_Label.text = "Imported file successful.\nScan ready."
            filename_Label.text = selectedFilePath.deletingLastPathComponent().lastPathComponent + "/" + selectedFilePath.lastPathComponent
            
            if(selectedFilePath.pathExtension == "txt"){
                fileContent = try String(contentsOf: selectedFileURL, encoding: .utf8)
                pathExtension = "txt"
            }
            
            var rtfString: NSAttributedString
            
            if(selectedFilePath.pathExtension == "rtf"){
                rtfString = try NSAttributedString(url: selectedFilePath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                
                fileContent = rtfString.string
                pathExtension = "rtf"
            }
            
            
            startScan_Button.isHidden = false
        } catch {
            header_Label.text = "Error: Import failed."
        }
        
    }
}

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}
