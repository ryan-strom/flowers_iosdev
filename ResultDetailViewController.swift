//
//  ResultDetailViewController.swift
//  flowers
//
//  Created by Ryan Stromberg on 4/17/16.
//  Copyright © 2016 Ryan Stromberg. All rights reserved.
//

import UIKit

class ResultDetailViewController: UIViewController {
    
    
    var result: Species?
    let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var countyLabel: UILabel!
    
    @IBOutlet weak var activeGrowthPeriodLabel: UILabel!
    
    @IBOutlet weak var flowerColorLabel: UILabel!
    
    @IBOutlet weak var growthFormLabel: UILabel!
    
    @IBOutlet weak var growthHabitLabel: UILabel!
    
    @IBOutlet weak var growthDurationsLabel: UILabel!
    
    @IBOutlet weak var growthRateLabel: UILabel!
    
    @IBOutlet weak var shapeLabel: UILabel!
    
    @IBOutlet weak var lifespanLabel: UILabel!
    
    @IBOutlet weak var toxicityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        print(result)
        
        
        backBtn.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let counties = result!.locations
        if (counties.isEmpty){
            countyLabel.text = "n/a"
        }
        else{
            countyLabel.text = counties.joinWithSeparator(", ")
        }
        
        if let activeGrowthPeriod = result?.active_growth_period {
            activeGrowthPeriodLabel.text = activeGrowthPeriod
        }
        else{
           activeGrowthPeriodLabel.text = "n/a"
        }
        
        if let flowerColor = result?.flower_color {
            flowerColorLabel.text = flowerColor
        }
        else{
            flowerColorLabel.text = "n/a"
        }
        
        if let growthForm = result?.growth_form {
            growthFormLabel.text = growthForm
        }
        else{
            growthFormLabel.text = "n/a"
        }
        
        if let growthHabit = result?.growth_habit {
            growthHabitLabel.text = growthHabit
        }
        else{
            growthHabitLabel.text = "n/a"
        }
        
        let growthDurations = result!.growth_duration
        if (growthDurations.isEmpty){
            growthDurationsLabel.text = "n/a"
        }
        else{
            growthDurationsLabel.text = growthDurations.joinWithSeparator(", ")
        }
        
        if let growthRate = result?.growth_rate {
            growthRateLabel.text = growthRate
        }
        else{
            growthRateLabel.text = "n/a"
        }
        
        if let shape = result?.shape {
            shapeLabel.text = shape
        }
        else{
            shapeLabel.text = "n/a"
        }
        
        if let lifespan = result?.lifespan {
            lifespanLabel.text = lifespan
        }
        else{
            lifespanLabel.text = "n/a"
        }
        
        if let toxicity = result?.toxicity {
            toxicityLabel.text = toxicity
        }
        else{
            toxicityLabel.text = "n/a"
        }
        
                
        
    }
    
    func goBack(sender:UIButton!)
    {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    

//    @IBOutlet weak var commNameLabel: UILabel!
//    
//    @IBOutlet weak var sciNameLabel: UILabel!
//    
//    @IBOutlet weak var featuresTable: UITableView!
//    
//
//    @IBOutlet weak var locationsLabel: UILabel!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        print(result!.common_name, result!.id)
//
//        // Do any additional setup after loading the view.
//        self.commNameLabel.text = result!.common_name
//        
//        let tmp : String = String(result!.id)
//        self.sciNameLabel.text = tmp
//        
//        result?.features_matching = ["Green", "5", "Yes"]
//        result?.locations = ["Bergen", "Monmouth", "Passaic"]
//        
//        var height : CGFloat = featuresTable.rowHeight;
//        height *= CGFloat((result?.features_matching.count)!);
//        
//        featuresTable.dataSource = self
//        featuresTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "featureCell")
//        
//        let locations = result?.locations.joinWithSeparator(", ")
//        self.locationsLabel.text = locations
////        countiesTable.dataSource = self
////        countiesTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "locationCell" )
//        
//        
//        
//    }
//    
// 
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == featuresTable{
//            return (result?.features_matching.count)!
//        }
//        return 0
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if tableView == featuresTable{
//            let cell = tableView.dequeueReusableCellWithIdentifier("featureCell", forIndexPath: indexPath)
//            cell.textLabel?.text = result?.features_matching[indexPath.item]
//            return cell
//        }
//        else {
//            let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath)
//            cell.textLabel?.text = result?.locations[indexPath.item]
//            return cell
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
