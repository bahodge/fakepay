task :cron => :environment do
  puts Cron::RenewSubscriptions.be_fab
  # EdiListener.process_new_messages

  puts "done."
end