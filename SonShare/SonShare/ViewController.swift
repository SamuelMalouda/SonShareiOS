//
//  ViewController.swift
//  SonShare
//
//  Created by Samuel Malouda on 08/09/2017.
//  Copyright © 2017 Samuel Malouda. All rights reserved.
//

import UIKit
import AVFoundation
import Social

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var audioplayer = AVAudioPlayer()
    
    func playSound(nom: String) {
        do {
            audioplayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: nom, ofType: "m4a")!))
            
            audioplayer.prepareToPlay()
            audioplayer.play()
        }
        catch {
            print(error)
        }
    }
    
    func playSoundMP3(nom: String) {
        do {
            audioplayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: nom, ofType: "mp3")!))
            
            audioplayer.prepareToPlay()
            audioplayer.play()
        }
        catch {
            print(error)
        }
    }
    
    func delSound() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        let fileDestinationUrl = documentDirectoryURL.appendingPathComponent("resultmerge.m4a") as URL
        
        let filemgr = FileManager.default
        
        if filemgr.fileExists(atPath: fileDestinationUrl.path) {
            if filemgr.isWritableFile(atPath: fileDestinationUrl.path) {
                do {
                    try filemgr.removeItem(atPath : fileDestinationUrl.path)
                }
                catch { print(error)}
                
            } else {
            }
        } else {
        }
        sleep(1)
    }
    
    func Merge(audio1: URL, audio2:  URL)
    {
        let composition = AVMutableComposition()
        
        let compositionAudioTrack1:AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
        
        let compositionAudioTrack2:AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
        
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        
        let fileDestinationUrl = documentDirectoryURL.appendingPathComponent("resultmerge.m4a") as URL
        
        let url1 = audio1
        let url2 = audio2
        
        let avAsset1 = AVURLAsset(url: url1 as URL, options: nil)
        let avAsset2 = AVURLAsset(url: url2 as URL, options: nil)
        
        var tracks1 = avAsset1.tracks(withMediaType: AVMediaTypeAudio)
        var tracks2 = avAsset2.tracks(withMediaType: AVMediaTypeAudio)
        
        let assetTrack1:AVAssetTrack = tracks1[0]
        let assetTrack2:AVAssetTrack = tracks2[0]
        
        let duration1: CMTime = assetTrack1.timeRange.duration
        let duration2: CMTime = assetTrack2.timeRange.duration
        
        let timeRange1 = CMTimeRangeMake(kCMTimeZero, duration1)
        let timeRange2 = CMTimeRangeMake(kCMTimeZero, duration2)
        do
        {
            try compositionAudioTrack1.insertTimeRange(timeRange1, of: assetTrack1, at: kCMTimeZero)
            try compositionAudioTrack2.insertTimeRange(timeRange2, of: assetTrack2, at: duration1)
        }
        catch
        {
            print(error)
        }
        
        delSound()
        
        let assetExport = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)
        assetExport?.outputFileType = AVFileTypeAppleM4A
        assetExport?.outputURL = fileDestinationUrl
        assetExport?.exportAsynchronously(completionHandler:
            {
                switch assetExport!.status
                {
                case AVAssetExportSessionStatus.failed:
                    print("failed")
                case AVAssetExportSessionStatus.cancelled:
                    print("cancelled")
                case AVAssetExportSessionStatus.unknown:
                    print("unknown")
                case AVAssetExportSessionStatus.waiting:
                    print("waiting")
                case AVAssetExportSessionStatus.exporting:
                    print("exporting")
                default:
                    print("complete")
                }
        })
    }
    
    
    func MergeVide(audio1: URL)
    {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        let fileDestinationUrl = documentDirectoryURL.appendingPathComponent("resultmerge.m4a") as URL
        let avAsset1 = AVURLAsset(url: audio1 as URL, options: nil)
        var tracks1 = avAsset1.tracks(withMediaType: AVMediaTypeAudio)
        let assetTrack1:AVAssetTrack = tracks1[0]
        let duration1: CMTime = assetTrack1.timeRange.duration
        let timeRange1 = CMTimeRangeMake(kCMTimeZero, duration1)
        let composition = AVMutableComposition()
        let compositionAudioTrack1:AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
        
        do
        {
            try compositionAudioTrack1.insertTimeRange(timeRange1, of: assetTrack1, at: kCMTimeZero)
        }
        catch
        {
            print(error)
        }
        
        let assetExport = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)
        assetExport?.outputFileType = AVFileTypeAppleM4A
        assetExport?.outputURL = fileDestinationUrl
        assetExport?.exportAsynchronously(completionHandler:
            {
                switch assetExport!.status
                {
                case AVAssetExportSessionStatus.failed:
                    print("failed")
                case AVAssetExportSessionStatus.cancelled:
                    print("cancelled")
                case AVAssetExportSessionStatus.unknown:
                    print("unknown")
                case AVAssetExportSessionStatus.waiting:
                    print("waiting")
                case AVAssetExportSessionStatus.exporting:
                    print("exporting")
                default:
                    print("complete")
                }
        })
        
        sleep(1)
    }
    
    
    func addSon(nom: String){
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        let fileDestinationUrl = documentDirectoryURL.appendingPathComponent("resultmerge.m4a") as URL
        
        let filemgr = FileManager.default
        
        let urlFile = URL.init(fileURLWithPath: Bundle.main.path(forResource: nom, ofType: "mp3")!)
        
        if filemgr.fileExists(atPath: fileDestinationUrl.path){
            Merge(audio1: fileDestinationUrl, audio2: urlFile)
        }else {
            MergeVide(audio1: urlFile)
        }
    }

    @IBAction func Son1(_ sender: Any) {
        playSoundMP3(nom: "dabdabdab")
        addSon(nom: "dabdabdab")
    }
    
    @IBAction func Son2(_ sender: Any) {
        playSoundMP3(nom: "ichich")
        addSon(nom: "ichich")
    }
    
    @IBAction func Partager(_ sender: Any) {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        let fileDestinationUrl = documentDirectoryURL.appendingPathComponent("resultmerge.m4a") as URL
        
        // Petit menu de partage
        let activityM = UIActivityViewController(activityItems: [fileDestinationUrl], applicationActivities: nil)
        activityM.popoverPresentationController?.sourceView = self.view
        
        self.present(activityM, animated: true, completion: nil)
    }

    @IBAction func Lecture(_ sender: Any) {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        let fileDestinationUrl = documentDirectoryURL.appendingPathComponent("resultmerge.m4a") as URL
        do {
            audioplayer = try AVAudioPlayer(contentsOf: fileDestinationUrl)
            
            audioplayer.prepareToPlay()
            audioplayer.play()
        }
        catch {
            print(error)
        }
    }
    
    
    @IBAction func BonneRep(_ sender: Any) {
        playSoundMP3(nom: "bonnereponse")
        addSon(nom: "bonnereponse")
    }
    
    @IBAction func Consulte(_ sender: Any) {
        playSoundMP3(nom: "consulte")
        addSon(nom: "consulte")
    }
    
    @IBAction func Jardiniere(_ sender: Any) {
        playSoundMP3(nom: "jardiniere")
        addSon(nom: "jardiniere")
    }
    
    @IBAction func Passe(_ sender: Any) {
        playSoundMP3(nom: "jepasse")
        addSon(nom: "jepasse")
    }
    
    @IBAction func Lalala(_ sender: Any) {
        playSoundMP3(nom: "lalala2")
        addSon(nom: "lalala2")
    }
    
    @IBAction func NeufDeux(_ sender: Any) {
        playSoundMP3(nom: "lepers92")
        addSon(nom: "lepers92")
    }
    
    @IBAction func Regale(_ sender: Any) {
        playSoundMP3(nom: "onseregale")
        addSon(nom: "onseregale")
    }
    
    @IBAction func PasCa(_ sender: Any) {
        playSoundMP3(nom: "pascadutout")
        addSon(nom: "pascadutout")
    }
    
    @IBAction func Suuh(_ sender: Any) {
        playSoundMP3(nom: "suuhfort")
        addSon(nom: "suuhfort")
    }
    
    @IBAction func Nul(_ sender: Any) {
        playSoundMP3(nom: "nulfort")
        addSon(nom: "nulfort")
    }
    
    @IBAction func CocoAlcool(_ sender: Any) {
        playSoundMP3(nom: "alcooleau")
        addSon(nom: "alcooleau")
    }
    
    @IBAction func F5(_ sender: Any) {
        playSoundMP3(nom: "f5f5f5")
        addSon(nom: "f5f5f5")
    }
    
    @IBAction func Svp(_ sender: Any) {
        playSoundMP3(nom: "hendecksvp")
        addSon(nom: "hendecksvp")
    }
    
    @IBAction func Oinj(_ sender: Any) {
        playSoundMP3(nom: "grosjoint")
        addSon(nom: "grosjoint")
    }
    
    @IBAction func Hendecks(_ sender: Any) {
        playSoundMP3(nom: "hendecks")
        addSon(nom: "hendecks")
    }
    
    @IBAction func Michtos(_ sender: Any) {
        playSoundMP3(nom: "michtos")
        addSon(nom: "michtos")
    }
    
    @IBAction func Gueudro(_ sender: Any) {
        playSoundMP3(nom: "guedro")
        addSon(nom: "guedro")
    }
    
    @IBAction func JoursGueudro(_ sender: Any) {
        playSoundMP3(nom: "joursguedro")
        addSon(nom: "joursguedro")
    }
    
    @IBAction func TousJours(_ sender: Any) {
        playSoundMP3(nom: "ttlesjours")
        addSon(nom: "ttlesjours")
    }
    
    @IBAction func Ursus(_ sender: Any) {
        playSoundMP3(nom: "ursus")
        addSon(nom: "ursus")
    }
    
    @IBAction func Rap2016(_ sender: Any) {
        playSoundMP3(nom: "rap2016fort")
        addSon(nom: "rap2016fort")
    }
    
    @IBAction func Dab(_ sender: Any) {
        playSoundMP3(nom: "dab")
        addSon(nom: "dab")
    }
    
    @IBAction func DabDabDab(_ sender: Any) {
        playSoundMP3(nom: "dabdabdab")
        addSon(nom: "dabdabdab")
    }
    
    @IBAction func Zoro(_ sender: Any) {
        playSoundMP3(nom: "zorofort")
        addSon(nom: "zorofort")
    }
    
    @IBAction func Init(_ sender: Any) {
        delSound()
    }
    
    @IBAction func IchIch(_ sender: Any) {
        playSoundMP3(nom: "ichich")
        addSon(nom: "ichich")
    }
    
    
    
    
    
    
    
}

