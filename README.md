[![Build Status](https://travis-ci.org/mplacona/Top40UK.png?branch=master)](https://travis-ci.org/mplacona/Top40UK)

# Top40UK - v 0.3
---
Gets the Official Top 40 Albums and Singles and turns it into readable JSON

## Changes
- v0.3
  - Add FR charts

- v0.2 
  - Add US charts and refactor for new implementations
  - Add even more unit tests
  - Hook up with autotest for continuous integration

## Dependencies
* [Sinatra](http://www.sinatrarb.com/)
* [Nokogiri](http://nokogiri.org/)

## Quick start
- Clone or download this repo.
- Run `bundle install`
- Run `ruby app.rb`
- Access your app in `http://localhost:4567`

## Contribute
Github is all about contributions. I realize this project will only really work for people in th UK and US. How about [YOUR_COUNTRY_HERE]? I'd be happy to add it in, but you can also collaborate by adding it yourself.
Doing so is easy, as you just need to create a new endpoint for your country, and hook it up to the top40 albums and singles in your country.

## License
Copyright (c) 2013 [@marcos_placona](https://twitter.com/marcos_placona), [Marcos Placona](https://plus.google.com/111557456465418142877).  
[Placona.co.uk](http://www.placona.co.uk)
Licensed under the MIT license.
