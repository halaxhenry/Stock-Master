//
//  QuoteParent.swift
//  Stock Master
//
//  Created by Seungchul Ha on 2022/01/29.
//

import Foundation

struct QuoteParent: Codable {
    var quoteResponse: QuoteResponse
    init() {
        quoteResponse = QuoteResponse()
    }
}

struct QuoteResponse: Codable {
    var error: QuoteError?
    var result: [Stock]?
    init() {
        error = nil
        result = []
    }
}

struct QuoteError: Codable {
    var lang: String?
    var description: String?
    var message: String?
    var code: Int?
    init() {
        lang = ""
        description = ""
        message = ""
        code = 0
    }
}

struct Stock: Codable {
    var ask : Decimal?
    var askSize : Int?
    var averageDailyVolume10Day : Int?
    var averageDailyVolume3Month : Int?
    var bid : Double?
    var bidSize : Int?
    var bookValue : Decimal?
    var currency : String?
    var epsTrailingTwelveMonths : Decimal?
    var esgPopulated : Bool?
    var exchange : String?
    var exchangeDataDelayedBy : Int?
    var exchangeTimezoneName : String?
    var exchangeTimezoneShortName : String?
    var fiftyDayAverage : Decimal
    var fiftyDayAverageChange : Decimal?
    var fiftyDayAverageChangePercent : Decimal?
    var fiftyTwoWeekHigh : Decimal?
    var fiftyTwoWeekHighChange : Decimal?
    var fiftyTwoWeekHighChangePercent : Decimal?
    var fiftyTwoWeekLow : Decimal?
    var fiftyTwoWeekLowChange : Decimal?
    var fiftyTwoWeekLowChangePercent : Decimal?
    var fiftyTwoWeekRange : String?
    var financialCurrency : String?
    var firstTradeDateMilliseconds : Int?
    var fullExchangeName : String?
    var gmtOffSetMilliseconds : Int?
    var language : String?
    var longName : String?
    var market : String?
    var marketCap : Int?
    var marketState : String?
    var messageBoardId : String?
    var priceHint : Int?
    var priceToBook : Decimal?
    var quoteSourceName : String?
    var quoteType : String?
    var region : String?
    var regularMarketChange : Decimal?
    var regularMarketChangePercent : Decimal?
    var regularMarketDayHigh : Decimal?
    var regularMarketDayLow : Decimal?
    var regularMarketDayRange : String?
    var regularMarketOpen : Double?
    var regularMarketPreviousClose : Decimal?
    var regularMarketPrice : Decimal?
    var regularMarketTime : Int?
    var regularMarketVolume : Int?
    var sharesOutstanding : Int?
    var shortName : String?
    var sourceInterval : Int?
    var symbol : String?
    var tradeable : Bool?
    var trailingAnnualDividendRate : Double?
    var trailingAnnualDividendYield : Decimal?
    var trailingPE : Decimal?
    var trailingThreeMonthNavReturns : Decimal?
    var trailingThreeMonthReturns : Decimal?
    var triggerable : Bool?
    var twoHundredDayAverage : Double?
    var twoHundredDayAverageChange : Decimal?
    var twoHundredDayAverageChangePercent : Decimal?
    var ytdReturn : Decimal?
}
