//
//  Species.swift
//  flowers
//
//  Created by Ryan Stromberg on 4/10/16.
//  Copyright © 2016 Ryan Stromberg. All rights reserved.
//

import UIKit

class Species: NSObject {
    
    var id : Int
    var common_name : String
    var scientific_name : String = ""
    var locations : Array<String> = Array<String>()
    var flower_color: String = ""
    var growth_form: String = ""
    var growth_habit: String = ""
    var growth_duration: Array<String> = Array<String>()
    var growth_rate: String = ""
    var active_growth_period: String = ""
    var shape: String = ""
    var lifespan: String = ""
    var toxicity: String = ""
    

    init(id:Int, common_name:String){
        self.id = id
        self.common_name = common_name
    }
    
    
    
}
