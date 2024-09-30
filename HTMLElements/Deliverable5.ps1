$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://localhost/ToBeScraped.html
$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where {
$_.getAttributeNode("class").value -ilike "div-1" } | select innerText
$divs1