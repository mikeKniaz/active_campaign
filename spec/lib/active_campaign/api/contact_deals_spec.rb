# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCampaign::API::ContactDeals, :vcr do
  let(:client) { ActiveCampaign.client }

  let(:contact_id) { '8432' }
  let(:deal_id)    { '31475' }

  let(:contact_deal_params) do
    { contact: contact_id.to_s, deal: deal_id.to_s }
  end

  describe '#create_contact_deal' do
    subject(:response) { client.create_contact_deal(contact_deal_params) }

    after do
      if response.is_a?(Hash) && response[:contact_deal] && response.dig(:contact_deal, :id)
        client.delete_contact_deal(response.dig(:contact_deal, :id))
      end
    end

    it 'returns a contact deal hash' do
      expect(response).to include_json(contact_deal: contact_deal_params)
    end
  end

  describe '#show_contact_deals' do
    subject(:response) { client.show_contact_deals(deal_id) }

    let!(:contact_deal_id) do
      client.create_contact_deal(contact_deal_params).dig(:contact_deal, :id)
    end

    after do
      client.delete_contact_deal(contact_deal_id) if contact_deal_id
    end

    it 'returns an array of contact deal hashes' do
      expect(response[:contact_deals]).to include(a_hash_including(contact_deal_params))
    end
  end

  describe '#delete_contact_deal' do
    subject(:response) { client.delete_contact_deal(contact_deal_id) }

    let!(:contact_deal_id) do
      client.create_contact_deal(contact_deal_params).dig(:contact_deal, :id)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end
end
