module Upperkut
  class Serializer
    def initialize(options = {})
      @item_serializer = options.fetch(:item_body_serializer, ItemBodySerializer)
    end

    def encode(items)
      items = [items] unless items.is_a?(Array)

      items.map do |item|
        JSON.generate(
          'id' => item.id,
          'body' => item.body,
          'enqueued_at' => item.enqueued_at
        )
      end
    end

    def decode(items)
      items.each_with_object([]) do |item_json, memo|
        next unless item_json

        hash = JSON.parse(item_json)
        id, body, enqueued_at = hash.values_at('id', 'body', 'enqueued_at')
        body = @item_serializer.decode(body) unless body.is_a?(Hash)
        memo << Item.new(id: id, body: body, enqueued_at: enqueued_at)
      end
    end

    module ItemBodySerializer
      def self.encode(item)
        JSON.generate(item)
      end

      def self.decode(item_json)
        JSON.parse(item_json)
      end
    end
  end
end