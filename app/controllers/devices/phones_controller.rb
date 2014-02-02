module Devices
  class PhonesController < ApplicationController
    before_filter :authenticate_user!
    before_filter :assign_phone, only: [:edit, :update, :destroy]

    def new
      @phone = Phone.new
    end

    def create
      @phone = Phone.new phone_params
      @phone.owner = current_user
      if @phone.save
        render status: :created
      else
        render status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @phone.update(phone_params)
        render status: :ok
      else
        render status: :unprocessable_entity
      end
    end

    def destroy
      @phone.destroy
    end

    private

      def phone_params
        params.require(:phone).permit(:value)
      end

      def assign_phone
        @phone = Phone.find(params[:id]).decorate
      end
  end
end
