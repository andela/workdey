module Dashboard
  class TasksController < ApplicationController
    before_action :login_required
    before_action :set_task, only: [
      :update,
      :edit,
      :show,
      :destroy,
      :broadcast_task,
      :close_bid,
      :choose_bidder,
      :accept_task,
      :decline_task
    ]

    def new
      @task = Task.new
      @skillsets = Skillset.all.select(&:name)
    end

    def edit
      render "new"
    end

    def show
    end

    def update
      if @task.update(task_params)
        redirect_to [:dashboard, @task],
                    notice: "Your task has been successfully updated"
      else
        render "new"
      end
    end

    def broadcast_task
      if @task.update(broadcasted: true)
        Task.create_task_notification(@task)
        message = "Available Taskees have been notified"
        redirect_to [:dashboard, @task], notice: message
      else
        render "show"
      end
    end

    def create
      @task = Task.new(task_params)
      if @task.save
        redirect_to [:dashboard, @task], notice: "Your task has been created"
      else
        @skillsets = Skillset.all.select(&:name)
        render "new"
      end
    end

    def destroy
      @task.destroy
      redirect_to my_tasks_path
    end

    def close_bid
      @task.update(broadcasted: false)
      Task.send_notification(@task)
      redirect_to [:dashboard, @task], notice: "Bids successfully closed"
    end

    def choose_bidder
      @task.update(status: :started, taskee_id: params[:taskee_id])
      Task.send_notification(@task)
      redirect_to [:dashboard, @task], notice: "Bid successfully assigned"
    end

    def accept_task
      @task.update(status: :finished)
      Task.send_notification(@task, "Assigned task marked as finished")
      redirect_to [:dashboard, @task], notice: "Task accepted"
    end

    def decline_task
      @task.update(status: :unassigned)
      Task.send_notification(@task, "Assigned task has been declined")
      redirect_to [:dashboard, @task], notice: "Task declined!"
    end

    def search
      search_tasks = Task.search_for_available_need(params[:need])
      @tasks = search_tasks ?
        search_tasks.paginate(page: params[:page], per_page: 9) :
        []
    end

    private

    def task_params
      params.require(:task).permit(
        :name,
        :price,
        :start_date,
        :end_date,
        :time,
        :location,
        :description,
        :skillset_id,
        :longitude,
        :latitude,
        :min_price,
        :max_price
      ).merge(
        tasker_id: current_user.id,
        price_range: [params[:task][:min_price], params[:task][:max_price]]
      )
    end

    def set_task
      task = Task.find(params[:id])
      dashboard_redirect if dashboard_redirect?
      if task.status == "finished" && current_user.taskee?
        dashboard_redirect("Task was marked as finished by owner")
      else
        @task = task
      end
      @bids = Bid.where(task_id: task.id).paginate(page: params[:page])
      @skillsets = Skillset.all.select(&:name)
    end

    def dashboard_redirect?
      task = Task.find(params[:id])
      (current_user.tasker? && current_user.id != task.tasker_id) ||
        (current_user.taskee? && !task.broadcasted) ||
        (current_user.taskee? && task.status == "started" &&
         task.taskee_id != current_user.id)
    end

    def dashboard_redirect(message = "Task not found!")
      redirect_to dashboard_path, notice: message && return
    end
  end
end
