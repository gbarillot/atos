require 'exception_handler'

class Atos

  attr_accessor :root_path, :request_path, :response_path, :pathfile_path
  
  def initialize(*args)
  
    args.empty? ? paths = {} : paths = args.first
    
    # You may override those default paths on Class instanciation 
    @root_path      = paths[:root_path] || "#{Rails.root}/lib/atos"
    @request_path   = paths[:request_path] || "#{self.root_path}/bin/request"
    @response_path  = paths[:response_path] || "#{self.root_path}/bin/response"
    @pathfile_path   = paths[:pathfile_path] || "#{self.root_path}/param/pathfile"
    
  end
      
  # Call the request binary 
  def request(datas)
  
    ExceptionHandler.before(datas)
        
    # Default parameters if nothing given
    datas[:merchant_country] ||= "fr"                # => French shop
    datas[:language]         ||= "fr"                # => French locale
    datas[:currency_code]    ||= "978"               # => Euro
    datas[:pathfile]         ||= "#{@pathfile_path}" # => Path to the Atos "pathfile"
         
    args = ''
    datas.each do |key, value|
      args << "#{key.to_s}=\"#{value}\" "
    end        
    
    response_array = ExceptionHandler.on_launch(`#{self.request_path} #{args}`)

    # If everything goes fine, should now respond an HTML form 
    response_array[3]
    
  end

  # Decrypt bank response, then return a hash
  def response(datas)

    response_array = ExceptionHandler.on_launch(`#{self.response_path} pathfile=#{self.pathfile_path} message=#{datas}`)

    { 
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

end
