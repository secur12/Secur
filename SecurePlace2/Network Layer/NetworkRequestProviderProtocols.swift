//
//  NetworkRequestWrapper.swift
//  Parlist
//
//  Created by Emil Karimov on 31.08.2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import Foundation

//protocol NetworkAccountRequestProtocol {
//    func updateFCMToken(completion: @escaping (NetworkError?) -> Void)
//    func registerUser(with email: String, password: String, name: String, username: String, completion: @escaping(RegistrationNegativeApiResponseModel?, RegistrationPositiveApiResponseModel?, NetworkError?) -> Void)
//}
//
//protocol NetworkMarketRequestProtocol {
//    func getCategories(page: Int, perPage: Int, completion: @escaping([MarketCategoryAPIResponseModel]?, NetworkError?) -> Void)
//    func getItemsBy(page: Int, perPage: Int, categoryId: String, completion: @escaping ([MarketItemDetailAPIResponseModel]?, NetworkError?) -> Void)
//    func likeItem(itemId: String, completion: @escaping (NetworkError?) -> Void )
//    func dislikeItem(itemId: String, completion: @escaping (NetworkError?) -> Void )
//}
//
//protocol NetworkCherdagramRequestProtocol {
//    func getPosts(page: Int, perPage: Int, completion: @escaping([PostApiResponseModel]?, NetworkError?) -> Void)
//    func likePost(postId: String, completion: @escaping(PostApiResponseModel?, NetworkError?) -> Void)
//    func dislikePost(postId: String, completion: @escaping(PostApiResponseModel?, NetworkError?) -> Void)
//}
//
//protocol NetworkBasketRequestProtocol {
//    func getBasket(page: Int, perPage: Int, completion: @escaping (BasketApiResponseModel?, NetworkError?) -> Void)
//    func removeItemsFromBasket(itemId: String, completion: @escaping ([BasketItemApiResponseModel]?, NetworkError?) -> Void)
//    func clearBasket(completion: @escaping (BasketApiResponseModel?, NetworkError?) -> Void)
//    func updateItemInBasket(itemBasketId: String, itemCount: Int, selectedSize: SizeModel, completion: @escaping (BasketItemApiResponseModel?, NetworkError?) -> Void)
//    func placeOrder(completion: @escaping (OrderApiResponseModel?, NetworkError?) -> Void)
//}
//
//protocol NetworkMusicRequestProtocol {
//    func getPlaylists(page: Int, perPage: Int, searchText: String?, completion: @escaping ([PlaylistApiResponseModel]?, NetworkError?) -> Void)
//    func getTracksBy(playlistId: String, storefrontId: String, searchText: String?, completion: @escaping (PlaylistDetailAPIResponseModel?, NetworkError?) -> Void)
//}
//
//protocol NetworkProfileRequestProtocol {
//    func savePromo(code: String, completion: @escaping (PromoApiResponseModel?, NetworkError?) -> Void)
//    func getFeedbacks(page: Int, perPage: Int, completion: @escaping([FeedbackAPIResponseModel]?, NetworkError?) -> Void)
//}
