require 'exception_handler'

class Atos

  attr_accessor :root_path, :request_path, :response_path, :pathfile_path
  
  def initialize(*args)
  
    args.empty? ? paths = {} : paths = args.first
    
    # You may override those default paths on Class instanciation 
    @root_path      = paths[:root_path] || "#{Rails.root}/lib/atos"
    @request_path   = paths[:request_path] || "#{@root_path}/bin/request"
    @response_path  = paths[:response_path] || "#{@root_path}/bin/response"
    @pathfile_path  = paths[:pathfile_path] || "#{@root_path}/param/pathfile"
    
  end
      
  # Call the request binary using request params
  def request(datas)
  
    ExceptionHandler.validate_request_params(datas)
        
    # Default parameters if nothing given
    datas[:merchant_country] ||= "fr"                # => French shop
    datas[:language]         ||= "fr"                # => French locale
    datas[:currency_code]    ||= "978"               # => Euro
    datas[:pathfile]         ||= "#{@pathfile_path}" # => Path to the Atos "pathfile"
         
    args = ''
    datas.each do |key, value|
      args << "'#{key.to_s}=#{value}' "
    end        

    ExceptionHandler.validate_binary_output(`#{@request_path} #{args}`)    
  end

  # Call the response binary using bank response
  def response(datas)

    response = ExceptionHandler.validate_binary_output(`#{@response_path} pathfile=#{@pathfile_path} message=#{datas}`)

    { 
      :code                   => response[1],
      :error                  => response[2],
      :merchant_id            => response[3],
      :merchant_country       => response[4],
      :amount                 => response[5],
      :transaction_id         => response[6],
      :payment_means          => response[7],
      :transmission_date      => response[8],
      :payment_time           => response[9],
      :payment_date           => response[10],
      :response_code          => response[11],
      :payment_certificate    => response[12],
      :authorisation_id       => response[13],
      :currency_code          => response[14],
      :card_number            => response[15],
      :cvv_flag               => response[16],
      :cvv_response_code      => response[17],
      :bank_response_code     => response[18],
      :complementary_code     => response[19],
      :complementary_info     => response[20],
      :return_context         => response[21],
      :caddie                 => response[22],
      :receipt_complement     => response[23],
      :merchant_language      => response[24],
      :language               => response[25],
      :customer_id            => response[26],
      :order_id               => response[27],
      :customer_email         => response[28],
      :customer_ip_address    => response[29],
      :capture_day            => response[30],
      :capture_mode           => response[31],
      :data                   => response[32]
    }      
    
  end    

end
