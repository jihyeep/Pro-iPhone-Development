//
//  CoreDataManager.swift
//  PetApp
//
//  Created by 박지혜 on 7/2/24.
//

import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        // 시동 걸기 - 비동기 처리
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data failed to initialize \(error.localizedDescription)")
            }
            
        }
    }
    
    // Create
    func savePet(name: String, breed: String) {
        let pet = Animal(context: persistentContainer.viewContext) /// 열고
        pet.name = name
        pet.breed = breed
        do {
            try persistentContainer.viewContext.save() /// 닫음
            print("Pet saved!")
        } catch {
            print("Falied to save \(error)")
        }
    }
    
    // Read (List)
    func getAllPets() -> [Animal] {
        let fetchRequest: NSFetchRequest<Animal> = Animal.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }

    // Delete
    func deletePet(animal: Animal) {
        persistentContainer.viewContext.delete(animal)
        do {
            try persistentContainer.viewContext.save() /// 닫음
        } catch {
            persistentContainer.viewContext.rollback() /// 되돌림
            print("Failed to save context \(error.localizedDescription)")
        }
    }
}
