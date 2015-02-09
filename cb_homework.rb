require 'cb'
require 'pry'

# add our developer key to the cb gem configuration
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

# sort our jobs by their company name
jobs = results.model.jobs
jobs = jobs.sort_by do |job|
  job.company_name
end

# chunk our jobs by their company name
# http://ruby-doc.org/core-2.1.0/Enumerable.html#method-i-chunk
jobs = jobs.chunk do |job|
  job.company_name
end

# loop through each of the job chunks
jobs.each do |company_name, jobs|
  # output our company name and it's jobs
  puts company_name
  jobs.each do |job|
    puts " #{job.title} [#{job.location}]"
  end
  puts
end
