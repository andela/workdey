module Dashboard
  class BidsController < ApplicationController
    before_action :login_required
    before_action :get_task, only: [:new, :create]
    before_action :set_bid, only: [:update, :edit, :destroy]

    def new
      @bid = Bid.new
    end

    def create
      @bid = Bid.new(bid_params)
      if @bid.save
        create_bid_notification(@bid)
        redirect_to [:dashboard, @task], notice: "You have successfully made"\
          " a bid"
      else
        render :new
      end
    end

    def update
      if @bid.update(bid_params)
        create_bid_notification(@bid, "updated")
        redirect_to [:dashboard, @task], notice: "Bid successfully updated"
      else
        render :edit
      end
    end

    def destroy
      @bid.destroy
      redirect_to [:dashboard, @task], notice: "Bid successfully deleted"
    end

    private

    def set_bid
      @bid = Bid.find(params[:id])
      @task = Task.find(@bid.task_id)
    end

    def bid_params
      params.require(:bid).permit(
        :description,
        :start_date,
        :end_date,
        :price
      ).merge(
        user_id: current_user.id,
        task_id: @task.id
      )
    end

    def get_task
      @task = Task.find(params[:task_id])
    end

    def create_bid_notification(bid, action = "made")
      Notification.create(
        message: "#{bid.user.fullname} #{action} a bid",
        sender_id: bid.user_id,
        receiver_id: bid.task.tasker_id,
        notifiable: bid
      ).notify_receiver("broadcast_task")
    end
  end
end
