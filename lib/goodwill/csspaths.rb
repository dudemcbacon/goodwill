module Goodwill
  module CSSPaths
    # Auction Page
    # http://www.shopgoodwill.com/viewItem.asp?itemID=<itemID>
    BIDS_PATH = '#more_images'
    CURRENT_PRICE_PATH = 'body > span > div.itemdetail > div:nth-child(2) > div:nth-child(3) > div > table > tr:nth-child(2) > th'
    END_TIME_PATH = 'body > span > div.itemdetail > div:nth-child(2) > div:nth-child(2) > div > table > tbody > tr:nth-child(6) > td'
    ITEMID_PATH = 'body > span > div.itemdetail > div:nth-child(2) > div:nth-child(2) > div > table > tbody > tr:nth-child(3) > td'
    ITEM_TITLE_PATH = '#title > span'
    SELLER_PATH = 'body > span > div.itemdetail > div:nth-child(2) > div:nth-child(2) > div > table > tr:nth-child(7) > td > b'
  end
end
