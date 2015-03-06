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
  def self.validate_binary_output(kind, datas)
    
    response = datas.split("!")
    
    case response[1]
    when nil
      # No response at all from API
      raise "SIPS/Atos error : binary file does not respond ! Check your 'request' binary path, default is 'Rails.root/lib/atos/bin'"
    when "0"      
      # API responds 'ok', return the content
      return kind == :response ? response : response[3]
    else
      # API binary responds an error, formated in a HTML table. Let's strip tags before showing the error message
      raise "SIPS/Atos API binary file outputs : #{response[2].gsub(/<\/?[^>]*>/, '')}" 
    end
    
  end   
  
end
