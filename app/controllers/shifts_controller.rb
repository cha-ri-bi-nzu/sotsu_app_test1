require "date"

class ShiftsController < ApplicationController
  # before_action :set_shift, only: %i[ show edit update destroy ]

  def index
    @shifts = Shift.all
  end

  def show
    @group_users = User.all
    @shifts = Shift.where(user_id: @group_users.ids).where("working_day >= ?", DateTime.parse("2023-09-01").beginning_of_month).where("working_day <= ?", DateTime.parse("2023-09-01").end_of_month).order(user_id: :asc).order(working_day: :asc)
    @month = @shifts.first.working_day.month
    @days = []
    @shifts.first.working_day.all_month.each do |d|
      @days << d
    end
  end

  # 勤務形態毎の合計(中)と勤務時間の合計(高)も出力
  # indexに年と月のセレクトボタン(高)と、既にあるシフト(リンク)の一覧表示(中)(kaminariGem使う？)
  # edit・updateアクションとの共通動作のリファクタリング(showとcreateそれぞれで)

  # 設定model・controller等の作成(祝日反映の有無(中)、定休日設定(高)、勤務形態の設定(低))
  # 定休日はラジオボタン(他も？)

  # 勤怠テーブルはグループテーブルにも紐づける(ユーザーテーブルの紐付けは要らん？)

  def new
    @shift = Shift.new
  end

  def edit
  end

  def create
    

    # select_month = 
    next_month_last = Date.current.end_of_month >> 1
    # @users = @group.users.includes(sesired_holiday)
    @users = User.all
    # month_size = (@next_month_first >> 1) - @next_month_first 
    # next_month_first.end_of_month - now_month_first.end_of_month
    @days = []
    next_month_last.all_month.each do |d|
      @days << d
    end
    @days.each do |day|
      @users.each do |user|
        @shift = Shift.new
        @shift.working_day = day
        @shift.user_id = user.id
        if day.wday == 0 || day.wday == 6
          @shift.working_status_id = 1
        else
          @shift.working_status_id = 3
        end

        @shift.save
      end
    end


    
    respond_to do |format|
      if @shift.save
        format.html { redirect_to shift_url(@shift), notice: "Shift was successfully created." }
        format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to shift_url(@shift), notice: "Shift was successfully updated." }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shift.destroy

    respond_to do |format|
      format.html { redirect_to shifts_url, notice: "Shift was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_shift
      # @shift = Shift.where("working_day >= ?", DateTime.parse(select_month).beginning_of_month).where("working_day <= ?", DateTime.parse(select_month).end_of_month)
      # @user = User.all.includes(:shift).where("working_day >= ?", DateTime.parse("2023-09-01").beginning_of_month).where("working_day <= ?", DateTime.parse("2023-09-01").end_of_month).order(user_id: :asc).order(working_day: :asc)
    end

    def shift_params
      params.require(:shift).permit(:working_day, :user_id, :working_status_id)
    end
end
