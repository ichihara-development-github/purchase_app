Rails.configuration.stripe = {
  publishable_key:  ENV["publishable_key"],
  secret_key: ENV["secret_key"]
}

Stripe.api_key = ENV["secret_key"]

