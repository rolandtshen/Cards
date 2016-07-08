//
//  RealmHelper.swift
//  Cards
//
//  Created by Roland Shen on 7/5/16.
//  Copyright © 2016 Roland Shen. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmHelper {
    
    static func addCard(card: Card) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(card)
        }
    }
    
    static func deleteCard(card: Card) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(card)
        }
    }
    
    static func updateCard(origCard: Card, newCard: Card) {
        origCard.name = newCard.name
        origCard.imageData = newCard.imageData
        origCard.email = newCard.email
        origCard.job = newCard.job
        origCard.phoneNum = newCard.phoneNum
        origCard.modificationTime = newCard.modificationTime
    }
    
    static func getCards() -> Results<Card> {
        let realm = try! Realm()
        let cards = realm.objects(Card).sorted("modificationTime", ascending: true)
        return cards
    }
}