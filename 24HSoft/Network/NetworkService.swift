//
//  NetworkManager.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import Alamofire
import Foundation

final class NetworkService {
    private let baseUrl = "https://api.unsplash.com/photos/"
    private let endPoint = "?client_id="
    private let accessToken = SecretKey.key
    private let coreDataManager = CoreDataManager.shared
}

extension NetworkService: MainNetworkServiceProtocol {
    func fetchPhotos(isRefresh: Bool = false, completion: @escaping (Result<[PhotoModel], any Error>) -> Void) {

        if !isRefresh {
            let cachedPhotos = coreDataManager.fetchPhotos()
            if !cachedPhotos.isEmpty {
                completion(.success(cachedPhotos))
            }
        }

        AF.request(baseUrl + endPoint + accessToken)
            .responseDecodable(of: [PhotoModel].self) { [weak self] response in
            switch response.result {
            case .success(let photos):
                self?.coreDataManager.savePhotos(photos)
                completion(.success(photos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
