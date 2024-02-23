require 'elasticsearch/model'
client = Elasticsearch::Client.new(url:ENV['ELASTICSEARCH_URL']) do |f|
  f.adapter :net_http
end