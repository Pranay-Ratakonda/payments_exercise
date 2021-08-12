require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe "#validations" do
    let(:loan) { Loan.create!(funded_amount: 1000.0) }
    
    context 'when payment is not valid' do
      let(:payment){ Payment.new(amount: -100, loan_id: loan.id, payment_date: Date.parse('2020-01-01')) }
      it { expect(payment.valid?).to be_falsy }
    end

    context 'when payment loan is not valid' do
      let(:payment){ Payment.new(amount: 100, loan_id: 999, payment_date: Date.parse('2020-01-01')) }
      it { expect(payment.valid?).to be_falsy }
    end

    context 'when payment loan is not valid' do
      let(:payment){ Payment.new(amount: 100, loan_id: loan.id, payment_date: Date.parse('2030-01-01')) }
      it { expect(payment.valid?).to be_falsy }
    end

    context 'when payment valid' do
      let(:payment){ Payment.new(amount: 100, loan_id: loan.id, payment_date: Date.parse('2020-01-01')) }
      it { expect(payment.valid?).to be_truthy }
    end
  end
end
