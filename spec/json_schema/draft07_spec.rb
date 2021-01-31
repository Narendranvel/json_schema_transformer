# frozen_string_literal: true
require 'json'
require 'json_schema/version'
require 'json_schema/Constants'
require 'json_schema/draft07'

RSpec.describe JsonSchema::Draft07 do
  describe 'Success' do

    context 'with simple case' do
      let(:json) do
        {
          first: 'first',
          second: 2,
          third: 'third',
        }
      end

      let(:expected_schema) do
        {
          "$schema" => "http://json-schema.org/draft-07/schema",
          "description" => "The root schema comprises the entire JSON document.",
          'title' => 'The root schema',
          'type' => 'object',
          'properties' => {
            'first' => {
              'type' => 'string',
            },
            'second' => {
              'type' => 'integer',
            },
            'third' => {
              'type' => 'string',
            },
          },
          'required' => %w[first second third],
        }
      end

      it 'generates schema correctly' do
        expect(JsonSchema::Draft07.new(json.to_json).generate).to match expected_schema
      end
    end


    context 'with complex case' do
      let(:json) do
        {:id=>"0001", :type=>"donut", :name=>"Cake", :ppu=>0.55, :batters=>{:batter=>[{:id=>"1001", :type=>"Regular"}, {:id=>"1002", :type=>"Chocolate"}, {:id=>"1003", :type=>"Blueberry"}, {:id=>"1004", :type=>"Devil's Food"}]}, :topping=>[{:id=>"5001", :type=>"None"}, {:id=>"5002", :type=>"Glazed"}, {:id=>"5005", :type=>"Sugar"}, {:id=>"5007", :type=>"Powdered Sugar"}, {:id=>"5006", :type=>"Chocolate with Sprinkles"}, {:id=>"5003", :type=>"Chocolate"}, {:id=>"5004", :type=>"Maple"}]}
      end
      let (:expected_schema) do
        {"title"=>"The root schema", "description"=>"The root schema comprises the entire JSON document.", "$schema"=>"http://json-schema.org/draft-07/schema", "type"=>"object", "required"=>["id", "type", "name", "ppu", "batters", "topping"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}, "name"=>{"type"=>"string"}, "ppu"=>{"type"=>"number"}, "batters"=>{"type"=>"object", "required"=>["batter"], "properties"=>{"batter"=>{"type"=>"array", "items"=>{"anyOf"=>[{"type"=>"object", "required"=>["id", "type"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}}}, {"type"=>"object", "required"=>["id", "type"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}}}, {"type"=>"object", "required"=>["id", "type"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}}}, {"type"=>"object", "required"=>["id", "type"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}}}]}}}}, "topping"=>{"type"=>"array", "items"=>{"anyOf"=>[{"type"=>"object", "required"=>["id", "type"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}}}, {"type"=>"object", "required"=>["id", "type"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}}}, {"type"=>"object", "required"=>["id", "type"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}}}, {"type"=>"object", "required"=>["id", "type"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}}}, {"type"=>"object", "required"=>["id", "type"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}}}, {"type"=>"object", "required"=>["id", "type"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}}}, {"type"=>"object", "required"=>["id", "type"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}}}]}}}}
      end
      it 'generates schema correctly' do
        expect(JsonSchema::Draft07.new(json.to_json, array_validation: :any_of).generate).to match expected_schema
      end
    end

    context 'with nested hash' do
      let(:json) do
        {
          nested1: {
            nested2: {
              nested3: {
                nested4: {
                  nested5: '1',
                },
              },
            },
          },
        }
      end

      let(:expected_schema) do
        {
          "$schema" => "http://json-schema.org/draft-07/schema",
          "description" => "The root schema comprises the entire JSON document.",
          'title' => 'The root schema',
          'type' => 'object',
          'required' => %w[nested1],
          'properties' => {
            'nested1' => {
              'type' => 'object',
              'required' => %w[nested2],
              'properties' => {
                'nested2' => {
                  'type' => 'object',
                  'required' => %w[nested3],
                  'properties' => {
                    'nested3' => {
                      'type' => 'object',
                      'required' => %w[nested4],
                      'properties' => {
                        'nested4' => {
                          'type' => 'object',
                          'required' => %w[nested5],
                          'properties' => {
                            'nested5' => {
                              'type' => 'string',
                            },
                          },
                        },
                      },
                    },
                  },
                },
              },
            },
          },
        }
      end

      it 'generates schema correctly' do
        expect(JsonSchema::Draft07.new(json.to_json).generate).to match expected_schema
      end
    end

    context 'with complex case' do
      let(:json) do
        {
          _id: '5c4774c4192e39a7585275fd',
          index: 0,
          guid: 'fb233eda-9a74-446f-865d-6901e5da117a',
          isActive: true,
          balance: '$1,524.98',
          picture: 'http://placehold.it/32x32',
          age: 28,
          eyeColor: 'green',
          name: 'Perkins Harvey',
          gender: 'male',
          company: 'KOFFEE',
          email: 'perkinsharvey@koffee.com',
          phone: '+1 (841) 535-2493',
          address: '241 Madison Street, Templeton, Virginia, 1537',
          about: 'Incididunt in consequat est aliquip nulla et. '\
          'Eu laborum dolore magna et amet sint ad nulla ut '\
          'eu nostrud. Anim proident non officia ipsum aliqua '\
          'officia ex deserunt. Anim enim reprehenderit proident '\
          'consequat. Occaecat id anim nulla ut cupidatat deserunt '\
          'eu Lorem. Mollit ea nisi amet magna incididunt magna tempor '\
          "duis in consectetur Lorem.\r\n",
          registered: '2018-07-06T04:30:17 -03:00',
          latitude: 13.765856,
          longitude: -9.772866,
          tags: %w[
            est
            labore
            consectetur
            proident
            officia
            sit
            duis
          ],
          friends: [
            {
              id: 0,
              name: 'Brandy Taylor',
            },
            {
              id: 1,
              name: 'Toni Francis',
            },
            {
              id: 2,
              name: 'Frieda Owen',
            },
          ],
          nested: {
            object: {
              in: {
                other: {
                  object: '1',
                },
              },
            },
          },
          greeting: 'Hello, Perkins Harvey! You have 2 unread messages.',
          favoriteFruit: 'apple',
        }
      end
    end
  end
end
