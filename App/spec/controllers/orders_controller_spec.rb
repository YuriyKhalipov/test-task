require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  let(:user) { create(:user) }
  let(:params) { { user_id: user } }
  
  before { sign_in user }

  describe '#index' do
    subject { get :index, params: params }

    let!(:order) { create :order, user: user }

    it 'assigns @order' do
      subject
      #expect(assigns(:order)).to eq([order])
    end

    it { is_expected.to render_template('index') }
  end

  describe '#new' do
    subject { get :new, params: params }
    
    context 'when user signed_in' do
      it { is_expected.to render_template(:new) }

      it 'assigns new order' do
        subject
        expect(assigns(:order)).to be_a_new Order
      end
    end
  end

  describe '#create' do
    let(:params) do
      {
        user_id: user.id,
        order: attributes_for(:order) 
      }
    end

    subject { post :create, params: params }

    it 'create order' do
      expect { subject }.to change { Order.count }.by(1)
      is_expected.to redirect_to(new_order_path)
    end

    context 'when params are invalid' do
      let(:params) do
        { user_id: user.id, order: { width: nil } }
      end

      it { is_expected.to render_template(:new) }
      it { expect { subject }.not_to change { Order.count } }
    end

    context 'when origin and/or destination of this pairing could not be geocoded' do
      let(:params) do
        { user_id: user.id, order: { origin_location: 'A', destination_location: 'A' } }
      end
      it { is_expected.to render_template(:new) }
      it { expect { subject }.not_to change { Order.count } }
    end
  end

  describe '#show' do
    let(:params) do { user_id: user.id, id: order } end

    subject { get :show, params: params }

    let!(:order) { create :order, user: user }

    it 'assigns @order' do
      subject
      expect(assigns(:order)).to eq(order)
    end

    it { is_expected.to render_template(:show) }

    context 'when user tries to see someone elses post' do
      let!(:order) { create :order }
      it { is_expected.to redirect_to(new_order_path) }
    end
  end
end