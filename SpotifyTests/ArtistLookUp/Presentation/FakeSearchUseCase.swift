//
//  FakeSearchUseCase.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 8/07/22.
//

import Foundation
@testable import gndjf

/*
class FakeSearchUseCase: SearchUseCaseProtocol {
    func executeSearch(lookUp artist: String?, onSuccess: @escaping (ArtistLookUpAPIResponse) -> (Void), onError: @escaping (SearchUseCase.Error) -> (Void)) {
        if artist == nil {
            onError(SearchUseCase.Error.invalidEmptySearch)
        } else {
            onSuccess(ArtistLookUpAPIResponse(
                artists:
                    [ArtistInformation(name: "",
                                       popularity: 0,
                                       id: "",
                                       genres: [0: ""],
                                       images: [ArtistImages(height: 0, width: 0, url: "")]
                                      )],
                currentPagination: " ",
                followingPagination: " "
            ))
        }
    }
}
*/
