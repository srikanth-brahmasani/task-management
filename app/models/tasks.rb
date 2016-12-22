class Tasks < ActiveRecord::Base #singularize model name
  attr_accessible :deadline, :description, :is_archieved, :is_done, :priority, :reminder

  belongs_to :user
  default_scope { order(deadline: :desc) }

  scope :done_tasks, where(is_done: true, is_archieved: false)
  scope :archive_tasks, where(is_archieved: true)
  scope :open_tasks, where(is_done: false)
  scope :all_tasks



  #define association between task and user

  def self.to_csv
    attributes = %w{description priority}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |task|
        csv << attributes.map{ |attr| task.send(attr) }
      end
    end
  end

  def set_default
    self.is_done = false
    self.is_archieved = false
  end

end
