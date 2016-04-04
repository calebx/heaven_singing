class HomeController < ApplicationController
  def index
  end

  def draw
    @phone = params[:draw][:phone]
    @name = params[:draw][:name]
    @kid = Kid.where(name: @name, phone: @phone).first
    if @kid
      flash[:notice] = "抽签完成~"
      render :draw
    else
      flash[:alert] = "请检查您的输入信息！系统未找到您的报名信息"
      render :index
    end
  end
end
