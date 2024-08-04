require 'spec_helper'

RSpec.describe Upperkut::Serializer do
  describe '#decode' do
  
    context 'when collection has nil values' do
      it 'rejects nil and preserve collection' do
        serializer = Upperkut::Serializer.new

        items_json = [nil, nil, nil, '{"id":"my-job","body":{"id":2,"name":"value"}}']
        items = serializer.decode(items_json).map(&:body)

        expect(items).to eq(
          [
            'id' => 2,
            'name' => 'value'
          ]
        )
      end
    end
  end
end
