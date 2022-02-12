import Foundation
import UIKit
import AVFoundation
import Toaster
import SDWebImage
import MediaPlayer

// MARK: Delay Features
func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

// MARK: Open Url
func openUrlInSafari(strUrl : String) {
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(URL(string : strUrl)!, options: [:]) { (isOpen) in
            
        }
    } else {
        // Fallback on earlier versions
    }
}

// MARK: Loader
func showLoader() {
    AppDelegate().sharedDelegate().showLoader()
}

func removeLoader() {
    AppDelegate().sharedDelegate().removeLoader()
}

// MARK: Toast

func displayToast(_ message : String) {
    Toast.init(text: message).show()
}

// MARK: Timer
func secondsToHoursMinutesSeconds(_ seconds: Int) -> (hour: String, min: String, sec: String) {
    let hour = Int(seconds) / 3600
    let minute = Int(seconds) / 60 % 60
    let second = Int(seconds) % 60
    
    return(String(format: "%02i", hour),
           String(format: "%02i", minute),
           String(format: "%02i", second))
}

// MARK: Load/Display View
func displaySubViewtoParentView(_ parentview: UIView! , subview: UIView!) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    parentview.addSubview(subview);
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
    parentview.layoutIfNeeded()
}

func displaySubViewWithScaleOutAnim(_ view:UIView) {
    view.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    view.alpha = 1
    UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1.0, options: [], animations: {() -> Void in
        view.transform = CGAffineTransform.identity
    }, completion: {(_ finished: Bool) -> Void in
    })
}

func displaySubViewWithScaleInAnim(_ view:UIView) {
    UIView.animate(withDuration: 0.25, animations: {() -> Void in
        view.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        view.alpha = 0.0
    }, completion: {(_ finished: Bool) -> Void in
        view.removeFromSuperview()
    })
}

// MARK: Copy Text
func copyText(txt:String) {
     UIPasteboard.general.string = txt
}

// MARK: Share
func shareText(_ vc:UIViewController, _ text:String) {
    let textToShare = [ text ]
    let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = vc.view
    activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
    vc.present(activityViewController, animated: true, completion: nil)
}

func shareImage(_ vc:UIViewController, _ img:UIImage) {
    let imageToShare = [ img ]
    let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = vc.view
    activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
    vc.present(activityViewController, animated: true, completion: nil)
}

func shareImageWithText(_ vc:UIViewController,_ img:UIImage, _ txt:String ) {
    let img : UIImage = img
    let messageStr = txt
    let activityViewController:UIActivityViewController = UIActivityViewController(activityItems:  [img, messageStr], applicationActivities: nil)
    activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
    vc.present(activityViewController, animated: true, completion: nil)
}

// MARK: Date Time
func getCurrentTimeStampValue() -> String {
    return String(format: "%0.0f", Date().timeIntervalSince1970*1000)
}

func getCurrentDateInFromDateInCurrentTimeZone(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    return dateFormatter.string(from: date)
}

func getLocalTime() -> Date {
    let nowUTC = Date()
    let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
    guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
    return localDate
}

// MARK: Alert
func showAlertWithOption(_ title: String, message: String, btns: [String] = ["Yes", "Cancel"], completionConfirm: @escaping () -> Void, completionCancel: @escaping () -> Void) {
    let myAlert = UIAlertController(title:NSLocalizedString(title, comment: ""), message:NSLocalizedString(message, comment: ""), preferredStyle: UIAlertController.Style.alert)
    let rightBtn = UIAlertAction(title: btns[0], style: UIAlertAction.Style.default, handler: { (action) in
        completionConfirm()
    })
    let leftBtn = UIAlertAction(title: btns[1], style: UIAlertAction.Style.cancel, handler: { (action) in
        completionCancel()
    })
    myAlert.addAction(rightBtn)
    myAlert.addAction(leftBtn)
    AppDelegate().sharedDelegate().window?.rootViewController?.present(myAlert, animated: true, completion: nil)
}

func showAlert(_ title:String, message:String, completion: @escaping () -> Void) {
    let myAlert = UIAlertController(title:NSLocalizedString(title, comment: ""), message:NSLocalizedString(message, comment: ""), preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler:{ (action) in
        completion()
    })
    myAlert.addAction(okAction)
    AppDelegate().sharedDelegate().window?.rootViewController?.present(myAlert, animated: true, completion: nil)
}

// MARK: File Manager

func getDirectoryPath() -> (documentDirectory: String, cacheDirectory: String, tempDirectory: String) {
    let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let cacheDirectoryPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    let tempDirectoryPath = NSTemporaryDirectory()
    
    return (documentDirectory: documentDirectoryPath, cacheDirectory: cacheDirectoryPath, tempDirectory: tempDirectoryPath)
}

func createDirectory(path: String, directoryName: String) {
    let docURL = URL(string: path)!
    let dataPath = docURL.appendingPathComponent(directoryName)
    if !FileManager.default.fileExists(atPath: dataPath.path) {
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
}

func deleteDirectory(pathWithDirectoryName: String) {
    do {
        if FileManager.default.fileExists(atPath: pathWithDirectoryName) {
            try FileManager.default.removeItem(atPath: pathWithDirectoryName)
        } else {
            print("File does not exist")
        }
    } catch {
        print("An error took place: \(error)")
    }
}

func getListOfFilesFromDirectory(pathWithDirectoryName: String) -> [String] {
    var contentList = [String]()
    
    do {
        let contents = try FileManager.default.contentsOfDirectory(atPath: pathWithDirectoryName)
        for content in contents
        {
            let fullContentPath = content
            contentList.append(pathWithDirectoryName + fullContentPath)
        }
        return contentList

    } catch let error {
        print(error.localizedDescription)
        return contentList
    }
}

func saveImageIntoDirectory(pathWithDirectoryName: String, fileNameWithExtension: String, image: UIImage) {
    let filePath = pathWithDirectoryName + "/" + fileNameWithExtension
    if let data = image.pngData(), !FileManager.default.fileExists(atPath: filePath) {
        FileManager.default.createFile(atPath: filePath as String, contents: data, attributes: nil)
    }
}

func saveVideoIntoDirectory(pathWithDirectoryName: String, fileNameWithExtension: String, videoUrl: URL) {
    
    let filePath = pathWithDirectoryName + fileNameWithExtension
    do {
        let videoData = try Data(contentsOf: videoUrl)
        FileManager.default.createFile(atPath: filePath as String, contents: videoData, attributes: nil)
    } catch {
        print(error.localizedDescription)
    }
}

func renameFileInDirectory(sourcePath: URL, destinationPath: URL, _ complition: @escaping (Bool) -> Void) {
    if !FileManager.default.fileExists(atPath: destinationPath.path) {
        do {
            try FileManager.default.moveItem(at: sourcePath, to: destinationPath)
            complition(true)
        } catch let error {
            displayToast(error.localizedDescription)
            complition(false)
        }
    } else {
        complition(true)
    }
}

// MARK: Get Thumb From Video

func getThumbnailImage(forUrl url: URL) -> UIImage?
{
    let asset: AVAsset = AVAsset(url: url)
    let imageGenerator = AVAssetImageGenerator(asset: asset)
    imageGenerator.appliesPreferredTrackTransform = true
    
    do {
        let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
        return UIImage(cgImage: thumbnailImage)
    } catch let error {
        print(error)
    }

    return nil
}


// MARK: Get Image Form URL
func setImageFromUrl(_ picPath: String, img: UIImageView, placeHolder: String) {
    let imgUrl = picPath
    
    if picPath == "" {
        return
    }
    
    img.sd_imageIndicator = SDWebImageActivityIndicator.gray
    img.sd_setImage(with: URL(string : imgUrl)) { (image, error, caheType, url) in
        if error == nil {
            img.image = image
        } else {
            img.image = UIImage.init(named: placeHolder)
        }
    }
}

// MARK: System Controlles

func setSystemVolume(_ volume: Float) {
    let volumeView = MPVolumeView()
    let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.0001) {
        slider?.value = volume
    }
}
