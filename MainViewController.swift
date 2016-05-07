//
//  MainViewController.swift
//  flowers
//
//  Created by Ryan Stromberg on 4/21/16.
//  Copyright © 2016 Ryan Stromberg. All rights reserved.
//

import UIKit
import Just


class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var takePic: UIButton!
    
    var ResultsData:Array< Species > = Array < Species >()
    
    
    var imagePicker: UIImagePickerController!
    
    var cameraDisplayed : Bool = false
    
    var tableView = UITableView()
//    
//    @IBOutlet weak var imageView: UIImageView!
    // MARK: - Properties
  
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        takePic.addTarget(self, action: "makeCameraAppear:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //creating instance of the table view
        tableView.frame = CGRectMake(0, 20, self.view.frame.width, self.view.frame.height)
        //designing the frame of the table view
        tableView.dataSource = self
        //assigning the data source of the table view
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        //registering the cell's class
        self.view.addSubview(tableView)
        //adding view to the view controller
    }
    
    func takePhoto() {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func makeCameraAppear(sender:UIButton!){
        takePhoto()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(!cameraDisplayed){
            takePhoto()
            cameraDisplayed = true
        }
    }

    func sendImgData(plantImage: UIImage){
        // endpoint url as a string
        let urlString = Globals.baseUrl + Globals.postImgSuffix
        
        // Using a UIImage
        
        // returns the data for the plantImage in JPEG format. UIImagePNGRepresentation is also an option
        let data = UIImageJPEGRepresentation(plantImage, 1.0) // The float parameter is compression quality (1.0 is maximum)
        
        guard let plantData = data else { fatalError("Problem writing image data.") } // If for some reason data = nil, throw an error
        
        // Do the call
        if let uploadResult = Just.post(urlString, files:["image":.Data("uploadedImg.jpg", plantData, nil)])
            .json {
            print(uploadResult)
            self.extract_json(uploadResult as! NSData)
        }
    }
    
    func extract_json(jsonData:NSData)
    {
        
        do {
            if let json : AnyObject? = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? NSArray{
                if let posts_list = json
                {
                    for i in 0..<posts_list.count
                    {
                        if let post_obj = (posts_list as! NSArray)[i] as? NSDictionary
                        {
                            if let id = post_obj["id"] as? Int
                            {
                                
                                if let common_name = post_obj["common_name"] as? String
                                {
                                    
                                    let species = Species(
                                        id: id,
                                        common_name: common_name
                                    )
                                    
                                    ResultsData.append(species)
                                    
                                }
                            }
                        }
                    }
                }
                
            }
            
            do_table_refresh();
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
    }
    
    func extract_result_info(jsonData:NSData, species:Species) -> Species
    {
        let resultSpecies = Species(id: species.id,common_name: species.common_name)
        do {
            if let json : AnyObject? = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as?NSDictionary{
              
                if let scientific_name = json?["scientific_name"] as? String
                {
                    
                    resultSpecies.scientific_name = scientific_name
        
                }
                
                if let flower_color = json?["flower_color"] as? String
                {
                    
                    resultSpecies.flower_color = flower_color
                    
                }
                
                if let growth_form = json?["growth_form"] as? String
                {
                    
                    resultSpecies.growth_form = growth_form
                    
                }
                
                
                if let active_growth_period = json?["active_growth_period"] as? String
                {
                    
                    resultSpecies.active_growth_period = active_growth_period
                    
                }
                
                if let growth_habit = json?["growth_habit"] as? String
                {
                    
                    resultSpecies.growth_habit = growth_habit
                    
                }
                
                if let growth_rate = json?["growth_rate"] as? String
                {
                    
                    resultSpecies.growth_rate = growth_rate
                    
                }
                
                if let shape = json?["shape"] as? String
                {
                    
                    resultSpecies.shape = shape
                    
                }
                
                
                if let lifespan = json?["lifespan"] as? String
                {
                    
                    resultSpecies.lifespan = lifespan
                    
                }
                
                if let toxicity = json?["toxicity"] as? String
                {
                    
                    resultSpecies.toxicity = toxicity
                    
                }

                
                if let counties = json?["counties"] as? NSArray
                {
                    for i in 0..<counties.count
                    {
                        resultSpecies.locations.append(counties[i] as! String)
                        
                    }
                }
                
                if let growth_durations = json?["growth_duration"] as? NSArray
                {
                    for i in 0..<growth_durations.count
                    {
                        resultSpecies.growth_duration.append(growth_durations[i] as! String)
                        
                    }
                }
                
                
                
            }
        
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return resultSpecies
        
    }
    
   func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        let plantImg = info[UIImagePickerControllerOriginalImage] as! UIImage
        sendImgData(plantImg)
    
    }
    
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
  
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //datasource method returning the what cell contains
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = ResultsData[indexPath.row].common_name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        performSegueWithIdentifier("resultDetailSeque", sender: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //datasource method returning no. of rows
        return ResultsData.count
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("prepare for seque")
        if segue.identifier == "resultDetailSeque" {
            let detailViewController = segue.destinationViewController
                as! ResultDetailViewController
            
            let myIndexPath = tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            
            let species : Species = ResultsData[row]
            let getSpeciesSuffix = "/species/"+String(row)
            let getSpeciesUrl = Globals.baseUrl + getSpeciesSuffix
            let response = Just.get(getSpeciesUrl)
            print(response)
            let result = extract_result_info(response.content!, species: species)
            detailViewController.result = result
            
        }
    }
    
    

}
