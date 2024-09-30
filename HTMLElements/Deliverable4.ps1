$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://localhost/ToBeScraped.html
$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | select outerText
$h2s