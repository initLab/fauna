json.array!(@members_fees) do |members_fee|
  json.extract! members_fee, :id, :user_id, :month
  json.url members_fee_url(members_fee, format: :json)
end
