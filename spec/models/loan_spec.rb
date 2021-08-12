require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:loan) { Loan.create(funded_amount: 1000) }

  describe "#outstanding_balance" do
    it 'should return outstanding balance on loan' do
      Payment.create(loan_id: loan.id, amount: 100, payment_date: Date.parse("2021-01-01"))
      expect(loan.outstanding_balance).to eq 900
    end

  end
end
