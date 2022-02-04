require 'rspec'
require './task1.rb'

RSpec.describe Cargo do 
  let(:cargo1){Cargo.new}

  describe 'cargo_parameters' do
  	context 'when volume <= 100cm' do
  	  it '1' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("1", "10", "5", "2", "Moscow", "Moscow","1", "10", "5", "2", "Moscow", "Moscow") 
        expect(cargo1.cargo_parameters).to eq({:weight=>1.0, :length=>10.0, :width=>5.0, :height=>2.0, :distance=>1.0, :price=>1.0})
      end
    end

    context 'when volume > 100cm && weight <= 10kg' do
      it '2' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("1", "25", "15", "10", "Moscow", "Moscow","1", "25", "15", "10", "Moscow", "Moscow") 
        expect(cargo1.cargo_parameters).to eq({:weight=>1.0, :length=>25.0, :width=>15.0, :height=>10.0, :distance=>1.0, :price=>2.0})
      end
    end

    context 'when volume > 100cm && weight > 10kg' do
      it '3' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("15", "25", "15", "10", "Moscow", "Moscow","15", "25", "15", "10", "Moscow", "Moscow") 
        expect(cargo1.cargo_parameters).to eq({:weight=>15.0, :length=>25.0, :width=>15.0, :height=>10.0, :distance=>1.0, :price=>3.0})
      end
    end

    context 'when no origin location or no destination location' do
      it '4' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("1", "25", "15", "10", nil, nil,"1", "25", "15", "10", nil, nil) 
        expect(cargo1.cargo_parameters).to eq({:weight=>1.0, :length=>25.0, :width=>15.0, :height=>10.0, :distance=>0, :price=>0.0})
      end
    end
  end
end
