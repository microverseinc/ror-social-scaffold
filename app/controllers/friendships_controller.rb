class FriendshipsController < ApplicationController
  require 'will_paginate/array'
  before_action :actual_user

  def requests
    @requests = @user.request_list.paginate(page: params[:page], per_page: 30)
  end

  def pending
    @pendings = @user.pending_list.paginate(page: params[:page], per_page: 30)
  end

  def status
    @user.friendships.find_by(friend_id: params[:id]).update(status: true)
  end

  private

  def actual_user
    @user = current_user
  end
end
