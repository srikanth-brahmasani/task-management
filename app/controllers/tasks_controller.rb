class TasksController < ApplicationController
  # require './app/mailers/usermailer.rb'
  require "csv"
  before_filter :signed_in_user, only: [:home, :done, :archive]
  before_filter :task_item, only: [:mark_as_archive, :mark_as_done]
  # PriorityValues = [1, 2, 3, 4, 5, 6]

  def home
    @tag  = params[:tag]
    if @tag == 'done'
      @tasks = current_user.taskss.done_tasks

    elsif @tag == 'archive'
      @tasks = current_user.taskss.archive_tasks

    elsif @tag == 'all_tasks'
      @tasks = current_user.taskss.all_tasks
    else
      @tasks = current_user.taskss.open_tasks
    end
    @task = Tasks.new
    # @tasks = Array(@tasks)
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"all_tasks\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end

  end



  def create

    if !current_user.admin
      user = current_user
    else
      user = get_user_id_by_user_email(params[:user_id])
    end

    @task = user.taskss.build(params[:task]) #build task via user object
    @task.priority = params[:priority]
    if @task.save
      flash[:success] = "Task created!"
      redirect_to root_url
    else
      flash[:error] = "Task Failed!"
      # redirect_to root_url
    end
  end

  def all_tasks
    @all_tasks = Tasks.all
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"all_tasks\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
    # render 'all_tasks'
  end
  def show
    @tasks = Tasks.all #enforce user scoping
    # @tasks = @tasks.paginate(page: params[:page])
  end

  def mark_as_archive
    @task.toggle(:is_archieved).save
    redirect_to root_url

  end

  def mark_as_done
    @task.toggle(:is_done).save
    redirect_to root_url
  end


  private
  def task_item
    @task = Tasks.find(params[:id])
  end


end