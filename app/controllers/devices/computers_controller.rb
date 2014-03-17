module Devices
  class ComputersController < ApplicationController
    before_filter :authenticate_user!
    before_filter :assign_computer, only: [:edit, :update, :destroy]

    def new
      @computer = Computer.new
      @computer.value = Arp.mac_by_ip_address(request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip)
    end

    def create
      @computer = Computer.new computer_params
      @computer.owner = current_user
      if @computer.save
        render status: :created
      else
        render status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @computer.update(computer_params)
        render status: :ok
      else
        render status: :unprocessable_entity
      end
    end

    def destroy
      @computer.destroy
    end

    private

      def computer_params
        params.require(:computer).permit(:value)
      end

      def assign_computer
        @computer = Computer.find(params[:id]).decorate
      end
  end
end
