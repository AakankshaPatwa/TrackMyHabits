class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: [:show, :edit, :update, :destroy]

  # GET /habits
  def index
    @habits = current_user.habits.includes(:habit_checkins)
  end

  # GET /habits/new
  def new
    @habit = current_user.habits.new
  end

  # POST /habits
  def create
    @habit = current_user.habits.new(habit_params)
    if @habit.save
      redirect_to habits_path, notice: 'Habit was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /habits/:id/edit
  def edit
  end

  def show
    @habit = current_user.habits.find(params[:id])
  end

  # PATCH/PUT /habits/:id
  def update
    if @habit.update(habit_params)
      redirect_to habits_path, notice: 'Habit was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /habits/:id
  def destroy
    @habit.destroy
    redirect_to habits_path, notice: 'Habit was successfully deleted.'
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:name, :description)
  end
end
