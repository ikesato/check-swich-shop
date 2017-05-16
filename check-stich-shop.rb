#!/usr/bin/env ruby
# coding: utf-8
$LOAD_PATH.push File.dirname(File.expand_path($0))
require 'omni7'
require 'toysrus'

shops = [
  {crawler: Omni7.new, name: "オムニ7"},
  {crawler: Toysrus.new, name: "トイザラス"},
]

availables = shops.map do |s|
  r = s[:crawler].check
  r ? {detail: r, name: s[:name]} : nil
end.compact

if availables.length > 0
  text = ["販売中！急げ！", ""]
  text << availables.map do |a|
    "- #{a[:name]}\n" + a[:detail].join("\n")
  end.join("\n")
  puts text.join("\n")
  exit 0
end

puts "在庫なし"
exit 1
