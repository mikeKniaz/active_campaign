# frozen_string_literal: true

module ActiveCampaign::API::ContactDeals
  def create_contact_deal(params)
    post('contactDeals', contactDeal: params)
  end

  def show_contact_deals(deal_id)
    get("deals/#{deal_id}/contactDeals")
  end

  def delete_contact_deal(id)
    delete("contactDeals/#{id}")
  end
end