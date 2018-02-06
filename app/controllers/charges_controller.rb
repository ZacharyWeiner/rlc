class ChargesController < ApplicationController
  layout 'reservations'
  def new
  end

  def create
    if params[:reservation_id]
      @reservation = Reservation.find(params[:reservation_id])
    end
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )


     if charge['paid'] == true
      p "******* paid *******"
      @reservation.paid = true
      @reservation.charge_id = charge['id']

      @reservation.save
      respond_to do |format|
        #ProposalMailer.deposit_received(@proposal).deliver_now

        format.html { redirect_to url_for(:controller => "reservations", :action => 'my_reservations', :q => @reservation.email, :escape => false) }
        format.json { head :no_content }
      end
    else
      p "******* failed *******"
      respond_to do |format|
        format.html { redirect_to edit_reservation_path(@reservation, notice: 'There was an Error Paying the Deposit') }
        format.json { head :no_content }
      end
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to my_reservations_path
  end
end






