//
//  CoreDataManager.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 18.06.2025.
//


import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Storage")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Photo Operations
    
    func savePhotos(_ photos: [PhotoModel]) {
        clearCache() // Очищаем старые данные перед сохранением новых
        
        for photo in photos {
            let photoEntity = PhotoEntity(context: context)
            photoEntity.id = photo.id
            photoEntity.color = photo.color
            photoEntity.photoDescription = photo.description
            photoEntity.altDescription = photo.altDescription
            photoEntity.likes = Int64(photo.likes ?? 0)
            
            if let urls = photo.urls {
                let urlsEntity = UrlsEntity(context: context)
                urlsEntity.thumb = urls.thumb
                urlsEntity.regular = urls.regular
                photoEntity.urls = urlsEntity
            }
            
            if let user = photo.user {
                let userEntity = UserEntity(context: context)
                userEntity.id = user.id
                userEntity.username = user.username
                photoEntity.user = userEntity
            }
        }
        
        saveContext()
    }
    
    func fetchPhotos() -> [PhotoModel] {
        let fetchRequest: NSFetchRequest<PhotoEntity> = PhotoEntity.fetchRequest()
        
        do {
            let photoEntities = try context.fetch(fetchRequest)
            return photoEntities.map { photoEntity in
                var photoModel = PhotoModel(
                    id: photoEntity.id,
                    color: photoEntity.color,
                    description: photoEntity.photoDescription,
                    altDescription: photoEntity.altDescription,
                    likes: Int(photoEntity.likes)
                )
                
                if let urlsEntity = photoEntity.urls {
                    photoModel.urls = UrlsModel(
                        thumb: urlsEntity.thumb,
                        regular: urlsEntity.regular
                    )
                }
                
                if let userEntity = photoEntity.user {
                    photoModel.user = UserModel(
                        id: userEntity.id,
                        username: userEntity.username
                    )
                }
                
                return photoModel
            }
        } catch {
            print("Error fetching photos: \(error)")
            return []
        }
    }
    
    func clearCache() {
        let photoFetchRequest: NSFetchRequest<NSFetchRequestResult> = PhotoEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: photoFetchRequest)
        
        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            print("Error clearing cache: \(error)")
        }
    }
}
