class Loan < ActiveRecord::Base
  has_many :payments

  def outstanding_balance
    funded_amount - payments.pluck(:amount).sum
  end

  def as_json(options={})
    {
      id: id,
      funded_amount: funded_amount,
      outstanding_balance: outstanding_balance,
      created_at: created_at
    }
  end
end
