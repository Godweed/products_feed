require 'spec_helper'

describe ProductsFeed::GoogleMerchant::Feed do
  let(:buffer) { StringIO.new }
  let(:items) {[
    {
      id: '1234',
      name: 'My awesome product',
      description: 'My awesome product',
      brand: 'Sex Toys Inc.',
      gtin: 'abc123',
      mpn: 'def123',
      price: 12.50,
      link: 'http://example.com/products/123',
      image_link: 'http://favva.nculo/stocazz.png',
    }
  ]}
  let(:feed) {
    ProductsFeed::GoogleMerchant::Feed.new(
      items,
      buffer,
      {
        title: 'Google Merchant feed',
        description: 'Google Merchant feed generated by Spree',
        link: 'http://example.com',
      }
    )
  }

  describe '#initialize' do
    it 'initializes a new GoogleMerchant::Feed' do
      expect(feed).to be_a(ProductsFeed::GoogleMerchant::Feed)
    end
  end

  describe '#generate' do
    it 'generates a Google Merchand feed' do
      feed.generate do |xml, item|
        # mandatory fields
        xml.field 'g:id', item[:id]
        xml.field 'g:title', item[:name]
        xml.field 'g:description', item[:description]
        xml.field 'g:link', item[:link]
        xml.field 'g:image_link', item[:image_link]
        xml.field 'g:condition', 'new' # 'new' 'used' 'refurbished'
        xml.field 'g:availability', 'in stock' #'in stock' 'out of stock' 'preorder'
        xml.field 'g:price', "#{item[:price]} USD"
        xml.field 'g:brand', item[:brand] # Brand of the item
        xml.field 'g:gtin', item[:gtin] # Global Trade Item Numbers
        xml.field 'g:mpn', item[:mpn] # Manufacturer Part Number

        # optional fields
        xml.field 'g:item_group_id', 'some group id'
        xml.field 'g:google_product_category', 'Software > Digital Goods & Currency'
        xml.field 'g:product_type', 'some product type'
      end

      buffer.rewind
      result = buffer.read
      expect(result).to_not be_empty
    end
  end
end