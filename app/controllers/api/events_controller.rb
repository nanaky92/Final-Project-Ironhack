class Api::EventsController < ApplicationController
  def send_reminders
    @user = current_user
    @group = Group.find(params["group"])
    @event = Event.find(params["event"])

    if @group.isUserAdmin?(@user)

      filter_users
      @users_to_remind.each do |user|
        EventMailer.reminder_votation(user, @group, @event).deliver_later
      end
      render json: {
        message: "Reminders sent",
        }, status: 200 
    else
      render json: {
        message: "You don't have permission for this",
        }, status: 400 
    end
  end


  def send_reminder
    @user = current_user
    @group = Group.find(params["group"])
    @event = Event.find(params["event"])

    if @group.isUserAdmin?(@user)

      @user_to_remind = User.find(params["user"])
      EventMailer.reminder_votation(@user_to_remind, @group, @event).deliver_later

      render json: {
        message: "Reminders sent",
        }, status: 200 
    else
      render json: {
        message: "You don't have permission for this",
        }, status: 400 
    end
  end

  def filter_users

    @users_to_remind = []

    @event.appointments.each do |appointment|
      appointment.votations.where(access: false).each do |votation|
        user = votation.user
        @users_to_remind.push(user) unless @users_to_remind.include?(user)
      end
    end
    # @users = []
    # @votations.each do |votation|
    #   @users.push(votation.user)
    # end
    # return @users
  end

end
