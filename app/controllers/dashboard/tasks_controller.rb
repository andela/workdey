module Dashboard
  class TasksController < ApplicationController
    before_action :login_required
    before_action :set_task,
      only: [
        :update,
        :show,
        :close_bid,
        :choose_bidder,
        :accept_task,
        :decline_task
    ]

      def new
        @task = Task.new
        @skillsets = Skillset.all.select(&:name)
      end

      def show
      end

      def update
        if @task.update(broadcasted: true)
          create_task_notification(@task)
          update_redirect("Available Taskees have been notified")
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

      def close_bid
        @task.update(broadcasted: false)
        create_chosen_notification(@task, "Assigned task has been closed")
        redirect_to [:dashboard, @task], notice: "Bids successfully closed"
      end

      def choose_bidder
        @task.update(status: :started, taskee_id: params[:taskee_id])
        create_chosen_notification(@task)
        redirect_to [:dashboard, @task], notice: "Bid successfully assigned"
      end

      def accept_task
        @task.update(status: :finished)
        create_chosen_notification(@task, "Assigned task marked as finished")
        redirect_to [:dashboard, @task], notice: "Task accepted"
      end

      def decline_task
        @task.update(status: :unassigned)
        create_chosen_notification(@task, "Assigned task been declined")
        redirect_to [:dashboard, @task], notice: "Task declined!"
      end

      def search
        search_tasks = Task.search_for_available_need(params[:need])
        @tasks = search_tasks ? paginate_tasks(search_tasks) : []
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
        if current_user.tasker? && current_user.id != task.tasker_id
          dashboard_redirect
        elsif current_user.taskee? && !task.broadcasted
          dashboard_redirect
        elsif current_user.taskee? &&
          task.status === "started" && task.taskee_id != current_user.id
          dashboard_redirect
        elsif task.status === "finished" && current_user.taskee?
          dashboard_redirect("Task was marked as finished by owner")
        else
          @task = task
        end
        @bids = Bid.where(task_id: task.id).paginate(page: params[:page])
      end

      def available_taskees(skillset)
        User.get_taskees_by_skillset(skillset)
      end

      def create_chosen_notification(task, message="You have been assigned")
        Notification.create(
          message: message,
          sender_id: task.tasker_id,
          receiver_id: task.taskee_id,
          notifiable: task
        ).notify_receiver("broadcast_task")
      end

      def create_task_notification(task)
        available_taskees(task.skillset.name).map do |taskee|
          NotificationMailer.send_broadcast_mail(task.tasker, taskee, task).
            deliver_now
          Notification.create(
            message: "New Task available that matches your skillset.",
            sender_id: task.tasker_id,
            receiver_id: taskee.id,
            notifiable: task
          ).notify_receiver("broadcast_task")
        end
      end

      def paginate_tasks(tasks)
        tasks.paginate(page: params[:page], per_page: 9)
      end

      def update_redirect(message)
        redirect_to [:dashboard, @task], notice: message
      end

      def dashboard_redirect(message="Task not found!")
        redirect_to dashboard_path, notice: message
      end
  end
end
