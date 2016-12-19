class Tasks < ActiveRecord::Base
  attr_accessible :deadline, :description, :is_archieved, :is_done, :priority, :reminder, :user_id



  def self.to_csv
    attributes = %w{description priority}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |task|
        csv << attributes.map{ |attr| task.send(attr) }
      end
    end
  end

end
