class Payment < ActiveRecord::Base
belongs_to :loan

  validates :loan_id, :amount, :payment_date, presence: true
  validates :amount, :numericality => { greater_than_or_equal_to: 0 }
  validate :validate_loan_payment_amount
  validate :future_date

  def future_date
    if payment_date && payment_date > Time.now
      errors.add(:payment_date, "Payment date can't be in future")
      false
    end
  end

  def validate_loan_payment_amount
    if loan && amount
      loan_outstanding_balance = loan.outstanding_balance
      if loan_outstanding_balance < amount
        errors.add(:amount, "amount can't be greater than loan outstanding amount")
        false
      end
    else
      errors.add(:loan_id, "Invalid Loan Id")
      false
    end
  end

  def as_json(options={})
    {
      loan_id: loan_id,
      amount: amount,
      payment_date: payment_date.strftime("%m-%d-%Y")
    }
  end

end
