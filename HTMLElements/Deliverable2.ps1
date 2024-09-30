$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://localhost/ToBeScraped.html
$scraped_page.Links