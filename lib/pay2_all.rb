class Pay2All

  def self.mobile_recharge(params, user_id)
    options = {query: {
        api_token: 'O6nJdKxErSiRwriq1CYguVUWCh9y262Dj9kPbVHMcRLt0oBrG8lGno1M7rD7',
        number: params[:number],
        provider_id:  params[:operator],
        amount: params[:amount],
        client_id: user_id
    }
    }
    result = HTTParty.get('https://www.pay2all.in/web-api/paynow', options )

    # else
    #   result = nil
    # end
  end


end