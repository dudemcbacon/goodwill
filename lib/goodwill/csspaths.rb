# frozen_string_literal: true

module Goodwill
  module CSSPaths
    # Auction Page
    # http://www.shopgoodwill.com/viewItem.asp?itemID=<itemID>
    BIDS_PATH = 'body > section > div.container > div:nth-child(3) > div:nth-child(2) > ul.product-data > li:nth-child(3) > span.num-bids'
    BIN_END_TIME_PATH = '/html/body/section/div[2]/div[3]/div[2]/ul[2]/li[7]'
    BUY_IT_NOW_PATH = '/html/body/section/div[2]/div[3]/div[2]/div[2]/div[1]/div/div/div/button'
    CURRENT_PRICE_PATH = 'body > section > div.container > div:nth-child(3) > div:nth-child(2) > ul.product-data > li:nth-child(4) > span'
    END_TIME_PATH = '/html/body/section/div[2]/div[3]/div[2]/ul[2]/li[10]'
    IN_PROGRESS_ROWS = '#my-auctions-table > tbody > tr'
    ITEMID_PATH = 'body > span > div.itemdetail > div:nth-child(2) > div:nth-child(2) > div > table > tbody > tr:nth-child(3) > td'
    ITEMS_COUNT_PATH = '//*[@id="search-results"]/div/div[1]/nav[1]/p'
    ITEM_TITLE_PATH = 'body > section > div.container > div:nth-child(3) > div:nth-child(2) > h1'
    NO_ITEMS_FOUND_PATH = '/html/body/section/div[2]/div[4]/div[2]/div/div[2]/p'
    SEARCH_ROWS = '#search-results > div > section > ul.products > li'
    SELLER_ID_LINK = '/html/body/section/div[2]/div[4]/div/section/div/ul/li[4]/a'
    SELLER_PATH = 'body > section > div.container > div:nth-child(3) > div:nth-child(2) > ul.product-data > li:nth-child(8) > a'
    SHIPPING_PATH = 'body > p:nth-child(7) > b'
  end
end
