//
//  AppDelegate.swift
//  Jewel
//
//  Created by Ethan Cardwell on 27/9/18.
//  Copyright © 2018 Ethan Cardwell. All rights reserved.
//
// GitHub: github.com/Xenthio/Jewel/
// Website: xenthio.github.io/jewel/


//import MyPeePeeInUrMum
import Cocoa
import WebKit
import Dispatch


//let webConfiguration = WKWebViewConfiguration()
//var webView = WKWebView(frame: .zero, configuration: webConfiguration)


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, WKNavigationDelegate {
    
    struct defaultsKeys {
        static let keyOne = "https://xenthio.github.io/homepage.html"
    }
    
    @IBOutlet weak var homepageis: NSTextField!
    
    
    @IBAction func homepage(_ sender: Any) { // apply settings in settings dialog
        
        UserDefaults.standard.set(homepageis.stringValue, forKey: "URL")
        //defaults.set(homepageis.stringValue, forKey: defaultsKey.keyOne)
    }
    
    @IBOutlet var CKRT: NSWindow!
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        self.webView.navigationDelegate = self
        // test for custom homepage
        
        //if let stringOne = defaults.string {
        //zlet name = UserDefaults.standard.string(forKey: "URL") ?? ""
        //if name != nil {
        //    let request = URLRequest(url: URL(string: name)!)
        //    webView?.load(request)  // Some String Value
        
        //} else {
            let request = URLRequest(url: URL(string: "https://xenthio.github.io/homepage.html")!)
            webView?.load(request) //load the homepage
        //}
        // TODO: Make it so the user can change the homepage.
        print("Launched Successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) // delayed so that the URL bar is blank
        })

        
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        print("Application Closed")
    }
    
    
    
    /*func webView(webView: WKWebView,
                 didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: NSError) {
        if error.code == -1001 { // TIMED OUT:
            let request = URLRequest(url: URL(string: "https://xenthio.github.io/error.html")!)
            webView.load(request)
        } else if error.code == -1003 { // SERVER CANNOT BE FOUND
            let request = URLRequest(url: URL(string: "https://xenthio.github.io/error.html")!)
            webView.load(request)
        } else if error.code == -1100 { // URL NOT FOUND ON SERVER
            let request = URLRequest(url: URL(string: "https://xenthio.github.io/error.html")!)
            webView.load(request)
        }
    }*/
    
    
    //-----------------------------------------------------------------------------------------//
    //                                 The main code for Jewel                                 //
    //-----------------------------------------------------------------------------------------//
    
    // Varable declarations:
    @IBOutlet var Winderps: NSWindow!
    @IBOutlet var title: NSTextField!
    @IBOutlet var urHome: NSButton!
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet var isSecure: NSButton!
    @IBOutlet var progressView: NSProgressIndicator!
    @IBOutlet var myURL: NSTextField!
    
    
    // Function declarations:
    
    // Here i present...!
    // The *amazing* Error Handler that i spent wayyy too much time researching on how to make it.
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let request = URLRequest(url: URL(string: "https://xenthio.github.io/error.html")!)
        webView.load(request)
        // TODO:
        // 1. make pages for specific errors
        // 2. make it pickup on the error and display the page for that specific error
    }
    // Super cool, am i right?
    
    var estWebload = 0
    
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            
            progressView.startAnimation(self)
            //print(webView.url) //used for debugging. re-enable if needed
            progressView.increment(by: 1.0) //updating the value because otherwise it will be nil.
            progressView.increment(by: -1.0)
            progressView.doubleValue = webView.estimatedProgress * 100 // basicly converts the 1.000 into 100.0
            // TODO: Make loading bar smoothly animated
            print(webView.estimatedProgress)
            myURL.stringValue = (webView.url?.absoluteString)! // Updates the url bar to show current page
            myURL.takeStringValueFrom(webView.url)
            urHome.isHidden = true
            print((webView.serverTrust! as! String)+" is trust?")
            if webView.hasOnlySecureContent == true {
                isSecure.isHidden = false
            } else {
                isSecure.isHidden = true
            } // fix because it does not work for some reason
            title.stringValue = webView.title!
            if webView.estimatedProgress == 1.0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.progressView.doubleValue = 0.1
                    self.progressView.doubleValue = 0.0
                    self.progressView.doubleValue = 0.0
                    self.progressView.doubleValue = 0.0
                    self.progressView.doubleValue = 0.1
                })

            } // fix because it used to work but stopped out of nowhere for some mysterious reason
            
        }
    }
    
    

    
    
    var repeatTimes = 0
    
    @IBAction func myURLonenter(_ sender: Any) {
        if myURL.stringValue.hasPrefix("http://") || myURL.stringValue.hasPrefix("https://") {
            // Detects if it's a URL
            webView?.customUserAgent = "the Super cool modern Web-Browser Ecks Dee version 4.20 premium w/ html5 and css 2019 edition"
            let request = URLRequest(url: URL(string: myURL.stringValue)!)
            webView?.load(request)
            print("Contains a url!")
            repeatTimes = 0
            print("System-Utility: Loaded " + myURL.stringValue + " successfully")
        } else {
            // Detects if it's a Google search
            let newString = myURL.stringValue.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil) //replaces spaces with pluses otherwise it'll crash.
            
            let request = URLRequest(url: URL(string: "https://www.google.com/search?q="+newString)!)
            
            webView?.load(request)
            
        }
    } // Loads URL input when Enter is pressed
    
    @IBAction func GoButton(_ sender: Any) {
        
        if myURL.stringValue.hasPrefix("http://") || myURL.stringValue.hasPrefix("https://") {
            // Detects if it's a URL
            webView?.customUserAgent = "the Super cool modern Web-Browser Ecks Dee version 4.20 premium w/ html5 and css 2019 edition"
            let request = URLRequest(url: URL(string: myURL.stringValue)!)
            webView?.load(request)
            print("Contains a url!")
            repeatTimes = 0
            print("System-Utility: Loaded " + myURL.stringValue + " successfully")
        } else {
            // Detects if it's a Google search
            let newString = myURL.stringValue.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil) //replaces spaces with pluses otherwise it'll crash.
            
            let request = URLRequest(url: URL(string: "https://www.google.com/search?q="+newString)!)
            
            webView?.load(request)
            
        }
    } //Loads URL input when GoButton is pressed

    

    //this is here to mark a location! Location: 4.D.C. KRET
    
    // ;)

}

//Ethan was Here
