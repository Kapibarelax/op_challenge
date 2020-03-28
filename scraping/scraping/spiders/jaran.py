# -*- coding: utf-8 -*-
import re
import dbm
import requests
from bs4 import BeautifulSoup
import scrapy
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor

from scraping.items import JaranItem

geocoding_cache = dbm.open('geocoding', 'c')

class JaranSpider(scrapy.Spider):
    name = 'jaran'
    allowed_domains = ['jalan.net']
    start_urls = ['https://www.jalan.net/kankou/130000/?screenId=OUW1211/']

    rules = [
        Rule(LinkExtractor(allow=r'/\w+/kankou/130000/page_\d+/'))
    ]

    def parse(self, response):
        geocoding_cache = dbm.open('geocoding', 'c')
        detail_urls = ['https:'+x for x in response.css('#cassetteType .item-info .item-name a::attr(href)').extract()]
        for url in detail_urls:
            print(url)
            yield scrapy.Request(url, callback=self.parse_detail)
        url = response.css('#rankList div.pager div a::attr(href)').extract_first()
        if not url:
            return
        else:
            print(url)
            yield scrapy.Request(url, callback=self.parse)
        geocoding_cache.close()

    def parse_detail(self, response):

        Item = JaranItem()
        Item['spot'] = response.css('.detailHeader-infoArea h1::text').extract_first()
        Item['category'] = ' '.join(response.css('.detailHeader-categories .c-genre .dropdownCurrent a::text').extract())
        Item['overview'] = '\n'.join(response.css('#aboutArea > p:nth-child(2)::text').extract())
        Item['review'] = response.css('#detailHeader > div.detailHeader-infoArea > div.detailHeader-ratingArea > div > span.reviewCount > a b::text').extract_first()
        Item['point'] = response.css('#detailHeader > div.detailHeader-infoArea > div.detailHeader-ratingArea > div > span.reviewPoint::text').extract_first()
        Item['address'] = re.sub('[\t \n]', '', response.css('#detailMap::text').extract()[0]).split('\u3000')[1]
        Item['link'] = response.url

        if Item['address'] not in geocoding_cache:
            payload = {'q':Item['address']}
            result = requests.get('http://www.geocoding.jp/api/', params=payload)
            if result.status_code == 200:
                ret = BeautifulSoup(result.content, 'lxml')
                Item['latitude'] = ret.find('lat').string
                Item['longuitude'] = ret.find('lng').string
                geocoding_cache[Item['address']] = Item['latitude']  + '_' +Item['longuitude']
                print('save cache')
            else:
                Item['latitude'] = ''
                Item['longuitude'] = ''
        else:
            print('use cache')
            coordinate = geocoding_cache[Item['address']].decode('utf-8')
            Item['latitude'] = coordinate.split('_')[0]
            Item['longuitude'] = coordinate.split('_')[1]

        yield Item
