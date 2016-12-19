namespace :reminder do
  desc ""
  task :cron => :environment do
    current_time = Time.now.utc
    from_time = current_time
    to_time = current_time + 1.hours
    users = User.all
    user_map = {}
    users.each do |user|
      user_map[user.id] = user.email
    end

    tasks = Array(Tasks.where(reminder:from_time..to_time))
    tasks.each do |task|
      description = task.description
      email = user_map[task.user_id]
      Usermailer.reminder_notification(email, description)
    end
    puts "completed"
  end
end
