class ExceptionHandler < StandardError
  
  # Minimum required parameters
  def self.validate_request_params(datas)
  
    required_params = [
      'merchant_id',
      'amount',
      'customer_id',
      'cancel_return_url',
      'normal_return_url',
      'automatic_response_url'
    ]
    
    required_params.each do |r| 
      raise "SIPS/Atos error : missing parameter '#{r}' in request" if !datas[r.to_sym]
    end
   
  end
  
  # Check if the request is ok
  def self.validate_binary_output(datas)
    
    response_array = datas.split("!")
    
    case response_array[1]
    when nil
      # No response at all from API
      raise "SIPS/Atos error : binary file does not respond ! Check your 'request' binary path, default is 'Rails.root/lib/atos/bin'"
    when "0"      
      # API responds 'ok', return the content
      response_array[3]
    else
      # API binary responds an error, formated in an HTML table. Let's strip tags before showing the error message
      raise "SIPS/Atos API binary file outputs : #{response_array[2].gsub(/<\/?[^>]*>/, '')}" 
    end
    
  end   
  
end
