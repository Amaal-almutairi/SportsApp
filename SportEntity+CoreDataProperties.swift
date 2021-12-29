//
//  SportEntity+CoreDataProperties.swift
//  SportsApp
//
//  Created by Amaal almutairi on 29/12/2021.
//
//

import Foundation
import CoreData


extension SportEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SportEntity> {
        return NSFetchRequest<SportEntity>(entityName: "SportEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var plyerEntity: PlyerEntity?

}

extension SportEntity : Identifiable {

}
