class PaymentsController < ActionController::API
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def create
    payment = Payment.new(payment_params)
    if payment.valid? && payment.save!
      render json: { message: "Payment created", status: :created }
    else
      render json: payment.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: Payment.find(params[:id])
  end

  private
  def payment_params
    params.require(:payment).permit(:payment_date, :amount, :loan_id)
  end
end
