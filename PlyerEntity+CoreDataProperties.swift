//
//  PlyerEntity+CoreDataProperties.swift
//  SportsApp
//
//  Created by Amaal almutairi on 29/12/2021.
//
//

import Foundation
import CoreData


extension PlyerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlyerEntity> {
        return NSFetchRequest<PlyerEntity>(entityName: "PlyerEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: String?
    @NSManaged public var hight: String?
    @NSManaged public var sportEntity: SportEntity?

}

extension PlyerEntity : Identifiable {

}
