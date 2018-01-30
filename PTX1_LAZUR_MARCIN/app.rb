#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

argument_1 = ARGV[0]
# argument_1 = "https://pl.wikipedia.org/wiki/Malowany_cz%C5%82owiek"
# argument_1 = "https://www.cdaction.pl/news-52437/dragon-ball-fighterz-miazdzy-konkurencje-na-steamie.html"

puts "Ekstraktowanie zdań ze strony:\n #{argument_1}\n\n"

page = Nokogiri::HTML(open(argument_1))

page.search("head").remove
page.search("table").remove
page.search("span").remove
page.search("li").remove
page.search("h3").remove

# puts page

tags = %w[p ol ul li h6 h5 h4 h3 h2 h1 em strong i b table thead tbody th tr td]
nodes = page.css(tags.join(", "))

nodes.each do |lines|
  if lines.text[/\A\s*\z/]
    next
  end
  lines.text.split(". ").each do |sentence|
    sentence = sentence.gsub /\t/, ""
    puts sentence + "."
  end
end