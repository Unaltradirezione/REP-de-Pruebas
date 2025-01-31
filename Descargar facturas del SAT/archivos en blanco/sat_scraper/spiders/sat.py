import scrapy

class SatSpider(scrapy.Spider):
    name = "sat"
    allowed_domains = ["sat.gob.mx"]
    start_urls = ["https://www.sat.gob.mx/"]

    def parse(self, response):
        pass
