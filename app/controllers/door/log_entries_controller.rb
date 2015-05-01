class Door::LogEntriesController < ApplicationController
  def create
    @log_entry = Door::LogEntry.new log_entry_params

    if @log_entry.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def log_entry_params
    params.permit :door, :latch
  end
end
