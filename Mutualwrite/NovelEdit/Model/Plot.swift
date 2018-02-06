//
//  Plot.swift
//  Mutualwrite
//
//  Created by MSlagger on 26/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import Foundation
import FirebaseDatabase

enum PlotType: String {
    case beginning = "beginning"
    case middle = "middle"
    case ending = "ending"
}

protocol PlotData {
    
    var content: String { get }
    var lastUpdate: String { get }
    var editByUserId: String { get }
    var editByUserName: String { get }
    var editByUserImageURL: String { get }
}

struct PlotItem: PlotData {
    
    var content: String
    var lastUpdate: String
    var editByUserId: String
    var editByUserName: String
    var editByUserImageURL: String
    var plotType: PlotType
    
    init(snap: DataSnapshot, plotType: PlotType) {
        
        let value = snap.value as! [String: Any]
        self.content = value ["content"] as! String
        self.lastUpdate = value["lastUpdate"] as! String!
        self.editByUserId = value["editByUserId"] as! String
        self.editByUserName = value["editByUserName"] as! String
        self.editByUserImageURL = value["editByUserImageURL"] as! String
        self.plotType = plotType
    }
    
}

struct Plot {
    
    var projectId: String?
    var plotbeginning: PlotItem?
    var plotMiddle: PlotItem?
    var plotEnding: PlotItem?
    
    init(snap: DataSnapshot) {
        
        let value = snap.value as? [String: Any]
        self.projectId = value?["projectId"] as? String
        
        for item in snap.children.allObjects as! [DataSnapshot] {
            
            let itemType = item.key
            switch itemType {
                
            case "beginning":
                self.plotbeginning = PlotItem(snap: item, plotType: .beginning)
                break
                
            case "middle":
                self.plotMiddle = PlotItem(snap: item, plotType: .middle)
                break
                
            case "ending":
                self.plotEnding = PlotItem(snap: item, plotType: .ending)
                break
            
            default:
                break
                
            }
        }
       
    }
}
