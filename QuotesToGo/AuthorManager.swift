//
//  AuthorManager.swift
//  QuotesToGo
//
//  Created by Jacob K Giberson on 3/5/16.
//  Copyright © 2016 Daniel Autenrieth. All rights reserved.
//

import UIKit

class AuthorManager: NSObject {
    
    class func addAuthor (name:String, completion:(author:Author) -> ()){
        let moc = CoreDataHelper.managedObjectContext()
        
        let predicate = NSPredicate(format: "name = %@", name)
        
        let authorFound = CoreDataHelper.fetchEntities(NSStringFromClass(Author), managedObjectContext: moc, predicate: predicate, sortDescriptor: nil)
        
        if authorFound.count > 0 {
            let author = authorFound.firstObject as! Author
            completion(author: author)
        }else{
            let author = CoreDataHelper.insertManagedObject(NSStringFromClass(Author), managedObjectContext: moc) as! Author
            author.name = name
            
            do {
                try WikiFace.faceForPerson(name, size: CGSizeMake(118, 118), completion: { (image: UIImage?, imageFound:Bool!) -> () in
                    if imageFound == true {
                        let faceImageView = UIImageView(image: image!)
                        faceImageView.contentMode = UIViewContentMode.ScaleAspectFill
                        WikiFace.centerImageViewOnFace(faceImageView)
                        
                        UIGraphicsBeginImageContextWithOptions(faceImageView.bounds.size, true, 0)
                        let context = UIGraphicsGetCurrentContext()
                        faceImageView.layer.renderInContext(context!)
                        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        
                        let imageData = UIImageJPEGRepresentation(croppedImage, 0.5)
                        author.image = imageData
                        try! moc.save()
                        completion(author: author)
                    } else{
                        author.image = nil
                        try! moc.save()
                        completion(author: author)
                    }
            })
            
            } catch WikiFace.WikiFaceError.CouldNotDownloadImage {
                print("could not access wikipedia")
                author.image = nil
                try! moc.save()
                completion(author: author)
                
            }catch {
                print(error)
            }
    }
    
    
    }
