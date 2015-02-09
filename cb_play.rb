require 'cb'
require 'pry'

Cb.configure do |config|
  config.dev_key    = 'WDHV3ZT6Y6HFN3QS2LSG'
  config.time_out   = 5
end

# available options: keyword, location, postedwithin, 
# excludeapplyrequirments, orderdirection, orderby,
# pagenumber, hostsite, siteentity, countrycode,
# advancedgroupingmode, enablecompanyjobtitlecollapse,
# groupingvalue
results = Cb.job.search({ location: 'Atlanta' })
response = results.response
response_job_search = response["ResponseJobSearch"]
errors = response_job_search["Errors"]
total_count = response_job_search["TotalCount"]
result_data = response_job_search["Results"]
real_result_data = result_data["JobSearchResult"]

real_result_data.each do |job_info|
  puts "TITLE: #{job_info["JobTitle"]}"
  puts "COMPANY: #{job_info["Company"]}"
end