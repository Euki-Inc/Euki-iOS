//
//  CoreDataManager.swift
//  Euki
//
//  Created by Víctor Chávez on 6/10/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
	static let sharedInstance = CoreDataManager()
	
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Euki")
		
		guard let description = container.persistentStoreDescriptions.first else {
			fatalError("Failed to retrieve a persistent store description.")
		}
		
		description.shouldAddStoreAsynchronously = false
		description.shouldMigrateStoreAutomatically = true
		description.shouldInferMappingModelAutomatically = true
		
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
}
