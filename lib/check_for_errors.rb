class CheckForErrors < StandardError
  
  # Minimum required parameters
  def self.before(datas)
  
    required_params = [
      'merchant_id',
      'amount',
      'customer_id',
      'cancel_return_url',
      'normal_return_url',
      'automatic_response_url'
    ]
    
    required_params.each do |r| 
      raise "Atos plugin error : missing parameter '#{r}' in request" if !datas[r.to_sym]
    end
   
  end
  
  # Check if the request is ok
  def self.on_launch(datas)
    
    response_array = datas.split("!")
    
    case response_array[1]
    when nil
      raise "Atos plugin error : binary file does not respond ! Check your 'request' binary path, default is 'Rails.root/lib/atos/bin'"
    when "0"      
      response_array
    else
      raise "Atos API binary file outputs : #{response_array[2].gsub(/<\/?[^>]*>/, '')}" 
    end
    
  end   
  
end
