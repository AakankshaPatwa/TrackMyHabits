class HabitCheckinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit

  # POST /habits/:habit_id/habit_checkins
  def create
    date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @habit.habit_checkins.create!(date: date)

    respond_to do |format|
      format.html { redirect_to habits_path, notice: "Marked done for #{date}." }
      format.turbo_stream
    end
  end

  # DELETE /habits/:habit_id/habit_checkins/:id
  def destroy
    @habit_checkin = @habit.habit_checkins.find(params[:id])
    @habit_checkin.destroy

    respond_to do |format|
      format.html { redirect_to habits_path, notice: "Check-in removed." }
      format.turbo_stream
    end
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
  end
end
