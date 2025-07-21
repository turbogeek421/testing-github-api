# frozen_string_literal: true

namespace :github do
  desc "Fetch all Github issues updated within the last given (default: 30) days"
  task :fetch_issues, %i[num_of_days] => %i[environment] do |_task, args|
    num_of_days = (args[:num_of_days] || 30).to_i
    puts "\nRunning service to import all Github issues updated within the last #{num_of_days} days"
    ImportGithubIssuesService.new(num_of_days.days.ago).call
    puts "Import completed"
    puts "#{Issue.count} Issues now stored in the database"
  end
end
