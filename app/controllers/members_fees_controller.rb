require 'pp'
class MembersFeesController < ApplicationController
  # GET /members_fees
  # GET /members_fees.json
  def index
    user_id = params[:user_id]
    if user_id
      @members_fees = MembersFee.where(user: user_id)
    else
      @members_fees = MembersFee.all
    end
  end

  # GET /members_fees/new
  def new
    @members_fee = MembersFee.new
  end

  # GET /members_fees/1/edit
  def edit
  end

  # POST /members_fees
  # POST /members_fees.json
  def create
    @members_fee = MembersFee.new(members_fee_params)

    respond_to do |format|
      if @members_fee.save
        format.html { redirect_to @members_fee, notice: 'Members fee was successfully created.' }
        format.json { render :show, status: :created, location: @members_fee }
      else
        format.html { render :new }
        format.json { render json: @members_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members_fees/1
  # PATCH/PUT /members_fees/1.json
  def update
    respond_to do |format|
      if @members_fee.update(members_fee_params)
        format.html { redirect_to @members_fee, notice: 'Members fee was successfully updated.' }
        format.json { render :show, status: :ok, location: @members_fee }
      else
        format.html { render :edit }
        format.json { render json: @members_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members_fees/1
  # DELETE /members_fees/1.json
  def destroy
    @members_fee.destroy
    respond_to do |format|
      format.html { redirect_to members_fees_url, notice: 'Members fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def members_fee_params
      params.require(:members_fee).permit(:user_id, :month)
    end
end
