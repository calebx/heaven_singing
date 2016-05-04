class HomeController < ApplicationController
  http_basic_authenticate_with name: "luedian_guest", password: "eqxiu", only: [:list]
  layout 'noodle', only: :try

  def index
  end

  def list
    @kids = Kid.includes(:lot).order(:group, "lots.number").all
    @count = @kids.count
  end

  def draw
    @name = params[:draw][:name].strip
    @phone = params[:draw][:phone].strip

    if @name.blank? || @phone.blank?
      flash[:alert] = "请检查您的输入信息，系统未找到您的报名信息~ "
      redirect_to root_path
      return
    end

    @kid = Kid.seek(@name, @phone)
    if @kid.present?
      flash[:notice] = @kid.lot ? "您已经抽过签了~" : "抽签完成~"
      @drawed = @kid.lot ? 1 : 0
      @lot = @kid.draw_a_lot
      render :draw
    else
      flash[:alert] = "请检查您的输入信息，系统未找到您的报名信息~ 如果您的报名时间超过了报名截止日期，系统也可能无法找到您报名信息；最终报名和抽签结果将在抽签结束后公布。"
      render :index
    end
  end

  def try
  end
end
