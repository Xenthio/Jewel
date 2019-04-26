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
import Foundation





//var webView = WKWebView(frame: .zero, configuration: webConfiguration)


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, WKNavigationDelegate, URLSessionDelegate {
   
    
    
//    let ToolsButton2 : NSButton!
//    let ToolsButton1 : NSButton!
//    let ToolsLabel : NSTextField!
//    let MenuButtonVAR : NSButton!
//    //var Tools: NSWindow!
//    let webView : WKWebView!
//    let isSecure : NSImageView!
//    let progressView : NSProgressIndicator!
//    let myURL : NSTextField!
//    let ToolMenu : NSBox!
    @IBOutlet var Jewel: mainJewelView!
    @IBOutlet weak var Tabs: NSTabView!
    
    var hi = 0
    
    
        
    lazy var ToolsButton2 = Jewel.ToolsButton2!
    lazy var ToolsButton1 = Jewel.ToolsButton1!
    lazy var ToolsLabel = Jewel.ToolsLabel!
    lazy var MenuButtonVAR = Jewel.MenuButtonVAR!
    //var Tools: NSWindow!
    lazy var webView = Jewel.webView!
    lazy var isSecure = Jewel.isSecure!
    lazy var progressView = Jewel.progressView!
    lazy var myURL = Jewel.myURL!
    lazy var ToolMenu = Jewel.ToolMenu!
    //lazy var GoButton = Jewel.GoButton((Any).self)

    @IBOutlet weak var NewTabTemplate: NSTabViewItem!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // TODO: MAKE TABS.
        // OR TODO: MAKE NEW WINDOW SYSTEM <---- DO THIS FIRST ACTUALLY
        
        //Tabs.
        //NewTabTemplate.label = webView.title!
        //Tabs.addTabViewItem(NewTabTemplate)
        Jewel.autoresizingMask = [.width, .height]
        Jewel.translatesAutoresizingMaskIntoConstraints = true
        // Create and Add Layout Constraint
        let leadingConstraint = Jewel.leadingAnchor.constraint(equalTo: Jewel.superview!.leadingAnchor, constant: 8.0)
        
        // Activate Layout Constraint
        leadingConstraint.isActive = true
//        Jewel.leadingAnchor.constraint(equalTo: Jewel.superview!.leadingAnchor).isActive = true
//        Jewel.topAnchor.constraint(equalTo: Jewel.superview!.topAnchor).isActive = true
//        Jewel.bottomAnchor.constraint(equalTo: Jewel.superview!.bottomAnchor).isActive = true
//        Jewel.trailingAnchor.constraint(equalTo: Jewel.superview!.trailingAnchor).isActive = true
//

        
        //if UserDefaults.standard.string(forKey: "Key") == nil {
        //homepageis.stringValue = "https://xenthio.github.io/homepage.html"
        //} else {
        //homepageis.stringValue = UserDefaults.standard.string(forKey: "Key")!
        //}
        Jewel.webView.navigationDelegate = self
        Jewel.webView?.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.2 Safari/605.1.15"
        // test for custom homepage
        
        //if let stringOne = defaults.string {
        //zlet name = UserDefaults.standard.string(forKey: "URL") ?? ""
        //if name != nil {
        //    let request = URLRequest(url: URL(string: name)!)
        //    webView?.load(request)  // Some String Value
        
        //} else {
        //let request = URLRequest(url: URL(string: "https://xenthio.github.io/homepage.html")!)
        
        if UserDefaults.standard.string(forKey: "HomePage") != nil {
            let request = URLRequest(url: URL(string:  UserDefaults.standard.string(forKey: "Homepage")!)!)
            Jewel.webView?.load(request) //load the homepage
        } else {
            UserDefaults.standard.set("https://xenthio.github.io/homepage.html", forKey: "Homepage")
            let request = URLRequest(url: URL(string:  UserDefaults.standard.string(forKey: "Key")!)!)
            Jewel.webView?.load(request) //load the homepage
            UserDefaults.standard.set(true, forKey: "HasBeenLaunchedBefore")
        }
        
        //}
        // TODO: Make it so the user can change the homepage.
        print("Launched Successfully")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.Jewel.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) // delayed so that the URL bar is blank
        })
        
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        print("Application Closed")
    }
 
    
    
    struct defaultsKeys {
        static let keyOne = "https://xenthio.github.io/homepage.html"
    }
    
    
    
    
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
  

    
    
    //-----------------------------------------------------------------------------------------//
    //                                 The main code for Jewel                                 //
    //-----------------------------------------------------------------------------------------//
    
    // Varable declarations:

    
    
    
    // Function declarations:
    
    // Here i present...!
    // The *amazing* Error Handler that i spent wayyy too much time researching on how to make it.
    // lets just say i got it correct the first time but turns out something else was breaking it
    /*func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
     //let request = URLRequest(url: URL(string: "https://xenthio.github.io/error.html")!)
     // i was an idiot and i did not pick up on the fact that if you were offline it could not display the error page.
     print("error was: LOOK BELOW")
     error
     print("DONE")
     webView.loadHTMLString("""
     <html>
     <head>
     <title>Whoops! i dont think you should be able to see the title as well what the heck???</title>
     </head>
     
     <body>
     <span style="font-family:arial,helvetica,sans-serif;">
     
     
     
     <span style="font-family:arial,helvetica,sans-serif;">
     <h1>Oh no! There was an Error!</h1>
     <h4>You could Try:</h4>
     Checking if you spelled the address correctly
     <br>
     or if you are connected to the internet
     <br>
     <br>
     TODO: MAKE BETTER ERROR PAGE
     <p>&nbsp;</p>
     
     </span>
     </span>
     </body>
     </html>
     """, baseURL: URL(string: "about:blank"))
     // TODO:
     // 1. make pages for specific errors
     // 2. make it pickup on the error and display the page for that specific error
     }*/
    // Super cool, am i right?
    
    var estWebload = 0
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let nserr = error as NSError
        if nserr.code == -1001 { // TIMED OUT:
            let request = URLRequest(url: URL(string: "https://xenthio.github.io/error.html")!)
            webView.load(request)
        } else if nserr.code == -1009 { // NOT CONNECTED TO THE INTERNET
            webView.loadHTMLString("""
            <html>
                <head>
                    <title>Whoops! i dont think you should be able to see the title as well what the heck???</title>
                </head>

                <body>
                    <span style="font-family:arial,helvetica,sans-serif;">
            
            
            
                        <span style="font-family:arial,helvetica,sans-serif;">
                            <h1>Cannot connect to the internet!</h1>
                            the most common of all!
                            <br>
                            <h4>you could try:</h4>
                            Turning on WIFI connections if it is disabled
                            <br>
                            Using a Wired connection
                            <br>
                            Restarting the Router
                            <br>
                            Restarting your Computer
                            <p>&nbsp;</p>
            
                        </span>
                    </span>
                </body>
            </html>
""", baseURL: URL(string: "about:blank"))
        } else if nserr.code == -1003 { // SERVER CANNOT BE FOUND
            webView.loadHTMLString("""
            <html>
                <head>
                    <title>Whoops! i dont think you should be able to see the title as well what the heck???</title>
                </head>

                <body>
                    <span style="font-family:arial,helvetica,sans-serif;">
            
            
            
                        <span style="font-family:arial,helvetica,sans-serif;">
                            <h1>Oh no! There was an Error!</h1>
                            <h4>it seems the server could not be found!</h4>
                            check if you spelled the address correctly
                            <br>
                            if you are the admin of this webpage, you know what to do.
                            <br>
                            <br>
                            TODO: MAKE BETTER ERROR PAGE
                            <p>&nbsp;</p>
            
                        </span>
                    </span>
                </body>
            </html>
""", baseURL: URL(string: "about:blank"))
        } else if nserr.code == -1100 { // URL NOT FOUND ON SERVER
            webView.loadHTMLString("""
            <html>
                <head>
                    <title>Whoops! i dont think you should be able to see the title as well what the heck???</title>
                </head>

                <body>
                    <span style="font-family:arial,helvetica,sans-serif;">
            
            
            
                        <span style="font-family:arial,helvetica,sans-serif;">
                            <h1>Uh oh!</h1>
                            The URL cannot be Found on Server
                            <br>
                            check if you typed in the url correctly!
                            <p>&nbsp;</p>
            
                        </span>
                    </span>
                </body>
            </html>
""", baseURL: URL(string: "about:blank"))
        } else {
            print(nserr.code)
            webView.loadHTMLString("""
            <html>
                <head>
                    <title>Whoops! i dont think you should be able to see the title as well what the heck???</title>
                </head>
                            <body><div class="lr_dct_ent vmod XpoqFe" data-hveid="CAIQBw"><div class="dDoNo gsrt" style="margin-bottom:0;line-height:normal"><h1>Unknown Error</h1></div><div class="vmod"><div class="lr_dct_ent_ph"><span class="lr_dct_ph XpoqFe">/<span>ʌnˈnəʊn&nbsp;ˈɛrə</span>/</span></div><div class="vmod"><div class="xpdxpnd vk_gy" data-mh="-1" aria-hidden="true"><span>adjective: <b>unknown</b></span></div><ol class="lr_dct_sf_sens"><li><div class="vmod"><div class="lr_dct_sf_sen Uekwlc XpoqFe"><div style="margin-left:20px"><div class="PNlCoe XpoqFe"><div style="display:inline" data-dobid="dfn"><span>We honestly have no idea what has happened.</span></div><span class="vmod"><div class="vk_gy">I have no clue on how to program... hurr durr, what is a sea plus plus?</div></span><div class="vmod"></div></div></div></div></div></li></ol></div></div></div></body></html>
            
                        </span>
                    </span>
                </body>
            </html>
""", baseURL: URL(string: "about:blank"))
        }
    }
    
    @IBAction func DownloadPage(_ sender: Any) {
        let config = URLSessionConfiguration.background(withIdentifier: "com.jewel.downloadin.background")
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
        let task = session.downloadTask(with: URL(string: myURL.stringValue)!)
        task.resume()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        if let response = navigationResponse.response as? HTTPURLResponse {
            if response.statusCode == 404 {
                // ...
            }
        }
        decisionHandler(.allow)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            
            
            
            //if var myURL = NSURL(string: "https://github.com/Xenthio/Jewel/releases/download/v1.1/Jewel.zip") {
            //    Downloader.load(myURL)
            //}
            
            Jewel.progressView.startAnimation(self)
            //print(webView.url) //used for debugging. re-enable if needed
            Jewel.progressView.increment(by: 1.0) //updating the value because otherwise it will be nil.
            Jewel.progressView.increment(by: -1.0)
            Jewel.progressView.doubleValue = webView.estimatedProgress * 100 // basicly converts the 1.000 into 100.0
            // TODO: Make loading bar smoothly animated
            print(webView.estimatedProgress)
            print("Wazzap")
            //print(webView.customUserAgent!)
            myURL.stringValue = (webView.url?.absoluteString)! // Updates the url bar to show current page
            //myURL.takeStringValueFrom(webView.url)
            //urHome.isHidden = true
            //let CurrentPage = webView.url?.absoluteString
            let NEWURL = myURL.stringValue.replacingOccurrences(of: ".github.io", with: ".gio")
            myURL.stringValue = NEWURL
            //myURL.takeStringValueFrom(NEWURL)
            //print("NEWURL = \(url!)")
            //print((webView.serverTrust! as! String)+" is trust?")
            
            DispatchQueue.main.async {
                if self.webView.hasOnlySecureContent {
                    self.isSecure.isHidden = false
                } else {
                    self.isSecure.isHidden = true
                } // fix because it does not work for some reason
            }
            //title.stringValue = webView.title!
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
    

    
    
    //this is here to mark a location! Location: 4.D.C. KRET
    
    // ;)

}

//Ethan was Here
