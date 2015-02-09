require 'cb'
require 'pry'

Cb.configure do |config|
  config.dev_key    = 'WDHV3ZT6Y6HFN3QS2LSG'
  config.time_out   = 5
end

# ask the important questions
puts "Where are you looking for a job?"
where = gets.chomp
puts "What kind of job are you looking for?"
what = gets.chomp

# the api wants keywords as comma seperated
keywords = what.split(" ").join(',')

# Use our CB job helper to search for jobs in atlanta
results = Cb.job.search({ location: where,
                          keywords: what })

response = results.response
response_job_search = response["ResponseJobSearch"]
errors = response_job_search["Errors"]
total_count = response_job_search["TotalCount"]

if total_count.to_i == 0
  puts "NO RESULTS"
elsif !errors.nil?
  puts "ERROR!: #{errors.join('|')}"
else
  result_data = response_job_search["Results"]
  real_result_data = result_data["JobSearchResult"]

  real_result_data.each do |job_info|
    puts "#{job_info["Company"]} :: #{job_info["JobTitle"]}"
  end
end