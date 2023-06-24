class NotificationsController < ApplicationController
  def index; end

  def destroy
    @notification = current_user.received_notifications
    return unless @notification.destroy_all

    flash[:success] = 'Todas as suas notificações foram lidas'
    redirect_to notifications_path
  end
end
