require 'test_helper'

describe Atos do

  it "Request: wrong arguments" do
    atos = Atos.new

    err = ->{ atos.request({}) }.must_raise RuntimeError
  end

  it "Request: Default paths should be valid ones" do
    atos = Atos.new
    
    atos.root_path.must_equal '/lib/atos'
    atos.request_path.must_equal '/lib/atos/bin/request'
    atos.response_path.must_equal '/lib/atos/bin/response'
    atos.pathfile_path.must_equal '/lib/atos/param/pathfile'
  end

  it "Default paths should be overridable at instanciation level" do
    atos = Atos.new(
      :root_path     => '/where',
      :request_path  => '/where/ever',
      :response_path => '/where/ever/you',
      :pathfile_path => '/where/ever/you/want'
    )
    
    atos.root_path.must_equal '/where'
    atos.request_path.must_equal '/where/ever'
    atos.response_path.must_equal '/where/ever/you'
    atos.pathfile_path.must_equal '/where/ever/you/want'
  end

  it "Params by default are set to fr/fr/Euro" do
    atos = Atos.new

    atos.send(:build_args, {}).must_equal "'merchant_country=fr' 'language=fr' 'currency_code=978' 'pathfile=/lib/atos/param/pathfile'"
  end

  it "Params by default are overridable" do
    atos = Atos.new
    params = {
      :merchant_id       => '014295303911111',
      :amount            => '1500',
      :customer_id       => '123456',
      :automatic_response_url=>'http://YOUR_SITE.com/ANY/LISTENING/URL/YOU/WANT',
      :normal_return_url => 'http://YOUR_SITE.com/NORMAL/FALLBACK/URL',
      :cancel_return_url => 'http://YOUR_SITE.com/CANCEL/URL'
    }

    atos.send(:build_args, params).must_equal "'merchant_id=014295303911111' 'amount=1500' 'customer_id=123456' 'automatic_response_url=http://YOUR_SITE.com/ANY/LISTENING/URL/YOU/WANT' 'normal_return_url=http://YOUR_SITE.com/NORMAL/FALLBACK/URL' 'cancel_return_url=http://YOUR_SITE.com/CANCEL/URL' 'merchant_country=fr' 'language=fr' 'currency_code=978' 'pathfile=/lib/atos/param/pathfile'"
  end

end
