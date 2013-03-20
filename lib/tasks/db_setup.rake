desc "setup db enviroment."
task :db_setup do
  unless Rails.env == 'production' 
    puts "1. Loading db configs; Create database and tables..."
    Rake::Task['db:setup'].invoke 
    puts "\n2. loading seed data..."
    Rake::Task['db:seed'].invoke 
    puts "\n3. create test tables..."
    %w(db:abort_if_pending_migrations environment db:load_config db:schema:load).each do |name|
      Rake::Task[name].reenable 
    end
    Rake::Task['db:test:prepare'].invoke
    puts "\ndb setup finished!"

  end
end

