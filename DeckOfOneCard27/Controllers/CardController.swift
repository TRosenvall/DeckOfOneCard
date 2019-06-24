//
//  CardController.swift
//  DeckOfOneCard27
//
//  Created by Timothy Rosenvall on 6/24/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class CardController {
    
    // Singleton
    
    // Source Of Truth
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    static func drawCard(completion: @escaping (Card?) -> Void) {
        // Step 1 - Unwrap our optional base URL
        guard let url = baseURL else{ completion(nil); return}
        
        // Step 2 - Contruct your final URL
        // url.appendingPathComponent("newCard") This is typically what we would end up doing.
        
        // Step 3 - Create a URLRequest from which to get data.
        // let request = URLRequest(url: url)
        
        // Step 4 - Get the data from the URL request
        // let data = try? Data(contentsOf: request) The code has changwd in recent versions.
        do{
            let data = try Data(contentsOf: url)
            let jDecoder = JSONDecoder()
            let topLevelJSON = try jDecoder.decode(TopLevelJSON.self, from: data)
            let card = topLevelJSON.cards[0]
            completion(card)
        } catch {
            print("Error getting data from URL \(error.localizedDescription) ")
            completion(nil)
            return
        }
    }
    
    static func getImage (card: Card, completion: (UIImage?) -> ()) {
        // Step 1 - Unwrap our optional base URL
        guard let url = URL(string: card.image) else { completion(nil); return}
        // Step 2 - Contruct your final URL
        // Step 3 - Create a URLRequest from which to get data.
        // Step 4 - Get the data from the URL request
        do{
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            completion(image)
        } catch {
            print("Error fetching image for card: \(card.code), error: \(error.localizedDescription)")
        }
    }
}
