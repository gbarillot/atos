class Atos
  
  # Initiate binary call, which should generate an HTML form with encrypted datas in a hidden input
  def self.request(datas)
    
    # Params Sanity check
    raise "Atos plugin Error : missing parameter 'merchant_id' in request" if !datas[:merchant_id]
    raise "Atos plugin Error : missing parameter 'amount' in request" if !datas[:amount]
    raise "Atos plugin Error : missing parameter 'customer_id' in request" if !datas[:customer_id]
    raise "Atos plugin Error : missing parameter 'cancel_return_url' in request" if !datas[:cancel_return_url]    
    raise "Atos plugin Error : missing parameter 'normal_return_url' in request" if !datas[:normal_return_url]
    raise "Atos plugin Error : missing parameter 'automatic_response_url' in request" if !datas[:automatic_response_url]
    
    
    # Test if Atos dirs are here 
    raise "Atos plugin Error : missing directory {RAILS_ROOT}/lib/atos/param" if !File.directory?("#{RAILS_ROOT}/lib/atos/param")
    raise "Atos plugin Error : missing file {RAILS_ROOT}/lib/atos/bin" if !File.directory?("#{RAILS_ROOT}/lib/atos/bin/")
        
    # Default parameters formating 
    datas[:merchant_country] ||= 'fr'
    datas[:language] ||= 'fr'
    datas[:currency_code] ||= '978' # => Default to Euro
    datas[:header_flag] ||= 'no'
    
    # Yeah, hurts my eyes too, but DON'T TOUCH THIS VAR ASSIGNMENT
    request ="merchant_id=#{datas[:merchant_id]}"
    request+=" merchant_country=#{datas[:merchant_country]}"
    request+=" amount=#{datas[:amount]}"
    request+=" currency_code=#{datas[:currency_code]}"
    request+=" pathfile=#{RAILS_ROOT}/lib/atos/param/pathfile"
    request+=" normal_return_url=#{datas[:normal_return_url]}"
		request+=" cancel_return_url=#{datas[:cancel_return_url]}"
		request+=" automatic_response_url=#{datas[:automatic_response_url]}"
		request+=" language=#{datas[:language]}"
		request+=" header_flag=#{datas[:header_flag]}"
		request+=" capture_day=#{datas[:capture_day]}"
		request+=" capture_mode=#{datas[:capture_mode]}"
		request+=" bgcolor=#{datas[:bgcolor]}"
		request+=" block_align=#{datas[:block_align]}"
		request+=" block_order=#{datas[:block_order]}"
		request+=" textcolor=#{datas[:textcolor]}"
		request+=" receipt_complement=#{datas[:receipt_complement]}"
		request+=" caddie=#{datas[:caddie]}"
		request+=" customer_id=#{datas[:customer_id]}"
		request+=" customer_email=#{datas[:customer_email]}"
		request+=" customer_ip_address=#{datas[:customer_ip_address]}"
		request+=" data=#{datas[:data]}"
		request+=" return_context=#{datas[:return_context]}"
		request+=" target=#{datas[:target]}"
		request+=" order_id=#{datas[:order_id]}"

    # Binary call, should response an HTML form in an array
    response = `#{RAILS_ROOT}/lib/atos/bin/request #{request}`

    # Now we've got a string separated by '!' => array[nil, error_flag(bool), error_message(string), HTML_form(string)]
    response_array = response.split("!")
    
    raise "Atos API Error : Binary file not found" if response_array.empty?
    raise "Atos API Error code : #{response_array[2]}" if response_array[1] != "0"

  
    # No problem : ouput only the HTML Form
    return response_array[3]
        
  end

  # Decrypt bank response, then return a hash
  def self.response(datas)

    response = `#{RAILS_ROOT}/lib/atos/bin/response pathfile=#{RAILS_ROOT}/lib/atos/param/pathfile message=#{datas}`

    response_array = response.split("!")
       
    if (response_array[1] != "0")
      out = {"Atos API Error in response" => "#{response_array[2]}"} 
    else
      # No problem, build response's hash
      out = { 
        :code                   => response_array[1],
        :error                  => response_array[2],
        :merchant_id            => response_array[3],
        :merchant_country       => response_array[4],
        :amount                 => response_array[5],
        :transaction_id         => response_array[6],
        :payment_means          => response_array[7],
        :transmission_date      => response_array[8],
        :payment_time           => response_array[9],
        :payment_date           => response_array[10],
        :response_code          => response_array[11],
        :payment_certificate    => response_array[12],
        :authorisation_id       => response_array[13],
        :currency_code          => response_array[14],
        :card_number            => response_array[15],
        :cvv_flag               => response_array[16],
        :cvv_response_code      => response_array[17],
        :bank_response_code     => response_array[18],
        :complementary_code     => response_array[19],
        :complementary_info     => response_array[20],
        :return_context         => response_array[21],
        :caddie                 => response_array[22],
        :receipt_complement     => response_array[23],
        :merchant_language      => response_array[24],
        :language               => response_array[25],
        :customer_id            => response_array[26],
        :order_id               => response_array[27],
        :customer_email         => response_array[28],
        :customer_ip_address    => response_array[29],
        :capture_day            => response_array[30],
        :capture_mode           => response_array[31],
        :data                   => response_array[32]
      }
    end
    
    return out
     
  end    
end
