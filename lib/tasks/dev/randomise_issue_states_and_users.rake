# frozen_string_literal: true

namespace :dev do
  desc "Updates imported Github issues to set a random (expected) states and randomised User assignment"
  task randomise_issue_states_and_users: :environment do
    unless Rails.env.development?
      puts "\n\n############################"
      puts "# FOR DEVELOPMENT USE ONLY #"
      puts "############################\n\n\n"
      return
    end

    user_ids = [nil] + User.ids

    Issue.find_each do |i|
      printf "."
      args = {
        state: Issue::EXPECTED_STATES.sample,
        user_id: user_ids.sample
      }
      i.update(args)
    end

    puts "\n\n #{Issue.pluck(:state).tally}\n\n"
  end
end
