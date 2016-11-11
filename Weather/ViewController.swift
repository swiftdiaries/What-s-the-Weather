//
//  ViewController.swift
//  Weather
//
//  Created by Adhita Selvaraj on 01/02/16.
//  Copyright (c) 2016 DreamCatcher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var City_TextField: UITextField!
    
    @IBAction func Go_Button(sender: AnyObject) {
        
        
        var url = NSURL(string: "http://www.weather-forecast.com/locations/" + City_TextField.text + "/forecasts/latest")
        
        if url != nil {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                
                var urlError = false
                var weather = ""
                
                if error == nil{
                    
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    
                    
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 0 {
                        
                        
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        
                        weather = weatherArray[0] as! String
                        
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        
                        
                        
                    }
                        
                    else{
                        urlError = false
                    }
                    
                    
                    
                    
                }
                    
                else{
                    urlError = true
                }
                
                dispatch_async(dispatch_get_main_queue()){
                    
                    
                    if urlError == true{
                        self.showError()
                    }
                        
                        
                    else{
                        self.Result_Label.text = weather
                    }
                    
                }
                
            })
            
            task.resume()
        }
            
        else{
            showError()
        }
        

        
    }
    
    @IBOutlet weak var Result_Label: UILabel!
    
    func showError()
    {
        Result_Label.text = "Could not load. Please try again."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
}

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
}

