class HomeController < ApplicationController
  http_basic_authenticate_with name: "luedian_guest", password: "eqxiu", only: [:list]
  def index
  end

  def list
    @kids = Kid.order(:group).all
    @count = @kids.count
  end

  def draw
    @name = params[:draw][:name].strip
    @phone = params[:draw][:phone].strip

    if @name.blank? || @phone.blank?
      flash[:alert] = "请检查您的输入信息，系统未找到您的报名信息"
      render :index
    end

    @kid = Kid.seek(@name, @phone)
    if @kid.present?
      flash[:notice] = @kid.drawed ? "您已经抽过签了~" : "抽签完成~"
      @kid.update(drawed: true)
      render :draw
    else
      flash[:alert] = "请检查您的输入信息，系统未找到您的报名信息"
      render :index
    end
  end
end
