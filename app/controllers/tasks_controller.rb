class TasksController < ApplicationController
  # require './app/mailers/usermailer.rb'
  require "csv"
  before_filter :signed_in_user,   only: [:home, :done, :Archive]
  def home

    @task = Tasks.new
    # @open_tasks = Tasks.all
    @priority_filters = Tasks.select(:priority).map(&:priority).uniq
    @priority_filters.unshift(nil)
    @filter_option = params[:filter]
    @all_users = get_user_emails
    if @filter_option
      @open_tasks = Tasks.where(is_done: [nil,false], priority:[@filter_option], user_id: [current_user.id]).order(['deadline'])

    else
      @open_tasks = Tasks.where(is_done: [nil,false], user_id: [current_user.id]).order(['deadline'])
    end

    reminder_tasks


  end


  def done
    @done_tasks = Tasks.where(is_done: [true], is_archieved:[nil, false] , user_id: [current_user.id]).order(['deadline'])

  end

  def archive
    @archive_tasks = Tasks.where(is_archieved:[true] , user_id: [current_user.id]).order(['deadline'])
  end

  def all_tasks
    @all_tasks = Tasks.all.reverse
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"all_tasks\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
    # render 'all_tasks'
  end

  def create
    @task = Tasks.new(params[:tasks])
    if !current_user.admin
      @task.user_id = current_user.id
      Usermailer.reminder_notification(@current_user.email, @task.description)
    else
      @task.user_id = get_user_id_by_user_email(params[:user_id]).id

    end
    if @task.save
      flash[:success] = "Task created!"
      redirect_to root_url
    else
      flash[:success] = "Task Failed!"
      redirect_to root_url
    end
  end

  def destroy
    @task = Tasks.find(params[:id])
    @task.destroy
    redirect_to root_url
  end


  def show
    @tasks = Tasks.all
    # @tasks = @tasks.paginate(page: params[:page])
  end

  def mark_as_archive
    @task = Tasks.find(params[:id])
    @task.toggle(:is_archieved)
    @task.save
    redirect_to root_url

  end

  def mark_as_done
    @task = Tasks.find(params[:id])
    @task.toggle!(:is_done)
    @task.save
    redirect_to root_url
  end


  def reminder_tasks

    current_time = Time.now.utc
    from_time = current_time
    to_time = current_time + 1000.hours
    users = User.all
    user_map = {}
    users.each do |user|
      user_map[user.id] = user.email
    end

    tasks = Array(Tasks.where(reminder:from_time..to_time))
    tasks.each do |task|
      description = task.description
      email = user_map[task.user_id]
      Usermailer.reminder_notification(email, description).deliver
    end
  end





end