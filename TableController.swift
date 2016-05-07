//
//  TableController.swift
//  flowers
//
//  Created by Ryan Stromberg on 4/10/16.
//  Copyright © 2016 Ryan Stromberg. All rights reserved.
//

import UIKit
import Just

class TableController: UITableViewController {
    var TableData:Array< String > = Array < String >()
    var ResultsData:Array< Species > = Array < Species >()
    
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
                                
                                if let title = post_obj["title"] as? String
                                {
                                
                                    TableData.append(title)
                                
                                    let species = Species(id: id, common_name: title)
                                    
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
    
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
    
    func get_data_from_url(url:String)
    {
        let response = Just.get(url)
        self.extract_json(response.content!)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        cell.textLabel?.text = TableData[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let url : String = "http://jsonplaceholder.typicode.com/posts"
        get_data_from_url(url)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 1
    //    }
    //
    //    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return TableData.count
    //    }
    //
    //    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    //        cell.textLabel?.text = TableData[indexPath.row]
    //        return cell
    //    }
    
    /*
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        print("prepare for seque")
        if segue.identifier == "resultDetails" {
            print("resultDetails")
            let detailViewController = segue.destinationViewController
                as! ResultDetailViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            let result : Species = ResultsData[row]
            detailViewController.result = result
            
        }
     }
    
    
}
