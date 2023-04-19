//
//  CoreDataHistorySaver.swift
//  gndjf
//
//  Created by Natalia Goyes on 19/08/22.
//

import CoreData
import UIKit


protocol CoreDataHistorySaverProtocol {
    func fetchArtist(with name: String, onSuccess: @escaping(ArtistInformation) -> Void, onError: @escaping(CoreDataHistorySaver.Error) -> Void)
}

class CoreDataHistorySaver {
    
    enum Error: Swift.Error {
        case unableToFetchArtist, mappingArtistFailed
    }
    
    
    func convertEntityToArtistInfo(_ entityFetched: FetchedArtist) -> ArtistInformation? {
        if let id = entityFetched.id, let imageURL = entityFetched.imageURL, let name = entityFetched.name, let genres = entityFetched.genres {
            return ArtistInformation(
                id: id,
                images: [ArtistImages(height: 1, width: 1, url: imageURL)],
                name: name,
                popularity: Int(entityFetched.popularity),
                genres: [genres]
            )
        } else {
            return nil
        }
    }
    
}

extension CoreDataHistorySaver: CoreDataHistorySaverProtocol {
    
    func fetchArtist(with name: String, onSuccess: @escaping(ArtistInformation) -> Void, onError: @escaping(CoreDataHistorySaver.Error) -> Void) {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            onError(.unableToFetchArtist)
            return
        }
        
        let context = delegate.coreDataManager.getViewContext()
        let fetchRequest: NSFetchRequest<FetchedArtist> = FetchedArtist.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: name, ascending: false)]
        
        do {
            let entityFetchedArtist = try context.fetch(fetchRequest)
            let fetchedArtist = entityFetchedArtist.map { entity in
                self.convertEntityToArtistInfo(entity)
            }
            if let artist = fetchedArtist[0] {
                onSuccess(artist)
            } else {
                onError(.mappingArtistFailed)
            }
        } catch {
            onError(.unableToFetchArtist)
        }
    }
    
}
