class Cron::RenewSubscriptions


  # ideally you spawn a worker for each of these subscriptions

  def self.renew_subscriptions!(subscribers)

    subscribers.each do |subscriber|
      customer = subscriber.customer
      subscription = subscriber.subscription
      if subscriber.customer.billing_token
        params = {amount: subscription.price}
        customer.subscribe_to_subscription!(params, subscription)
      end
    end
  end

  def self.run
    subscribers = Subscriber.select do |subscriber|
      subscriber.expires_soon? && subscriber.status != "TERMINATED"
    end
    renew_subscriptions!(subscribers)
  end

  def self.run_for_range(start_date, end_date)
    subscribers = Subscriber.select do |subscriber|
      subscriber.expires_at >= start_date &&
          subscriber.expires_at <= end_date &&
          subscriber.status != "TERMINATED"
    end
    renew_subscriptions!(subscribers)
  end


end