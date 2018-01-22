module Goodwill
  module CSSPaths
    # Auction Page
    # http://www.shopgoodwill.com/viewItem.asp?itemID=<itemID>
    BIDS_PATH = 'body > section > div.container > div:nth-child(3) > div:nth-child(2) > ul.product-data > li:nth-child(3) > span.num-bids'.freeze
    CURRENT_PRICE_PATH = 'body > section > div.container > div:nth-child(3) > div:nth-child(2) > ul.product-data > li:nth-child(4) > span'.freeze
    END_TIME_PATH = '/html/body/section/div[3]/div[3]/div[2]/ul[2]/li[10]/text()'.freeze
    ITEMID_PATH = 'body > span > div.itemdetail > div:nth-child(2) > div:nth-child(2) > div > table > tbody > tr:nth-child(3) > td'.freeze
    ITEM_TITLE_PATH = 'body > section > div.container > div:nth-child(3) > div:nth-child(2) > h1'.freeze
    SELLER_PATH = 'body > section > div.container > div:nth-child(3) > div:nth-child(2) > ul.product-data > li:nth-child(8) > a'.freeze
    SHIPPING_PATH = 'body > p:nth-child(7) > b'.freeze
  end
end
