require 'test_helper'

class AtosTest < ActiveSupport::TestCase

  test "request: wrong arguments" do
    atos = Atos.new

    assert_raise RuntimeError do
      atos.request({})
    end

  end

  test "Default paths should be valid ones" do
    atos = Atos.new
    
    assert_equal atos.root_path, '/lib/atos'
    assert_equal atos.request_path, '/lib/atos/bin/request'
    assert_equal atos.response_path, '/lib/atos/bin/response'
    assert_equal atos.pathfile_path, '/lib/atos/param/pathfile'
  end

  test "Default paths should be overridable at instanciation level" do
    atos = Atos.new(
      :root_path     => '/where',
      :request_path  => '/where/ever',
      :response_path => '/where/ever/you',
      :pathfile_path => '/where/ever/you/want'
    )
    
    assert_equal atos.root_path, '/where'
    assert_equal atos.request_path, '/where/ever'
    assert_equal atos.response_path, '/where/ever/you'
    assert_equal atos.pathfile_path, '/where/ever/you/want'
  end

  test "Params by default are set to fr/fr/Euro" do
    atos = Atos.new

    assert_equal atos.send(:build_args, {}), "'merchant_country=fr' 'language=fr' 'currency_code=978' 'pathfile=/lib/atos/param/pathfile'"
  end

  test "Params by default are overridable" do
    atos = Atos.new
    params = {
      :merchant_id       => '014295303911111',
      :amount            => '1500',
      :customer_id       => '123456',
      :automatic_response_url=>'http://YOUR_SITE.com/ANY/LISTENING/URL/YOU/WANT',
      :normal_return_url => 'http://YOUR_SITE.com/NORMAL/FALLBACK/URL',
      :cancel_return_url => 'http://YOUR_SITE.com/CANCEL/URL'
    }

    assert_equal atos.send(:build_args, params), "'merchant_id=014295303911111' 'amount=1500' 'customer_id=123456' 'automatic_response_url=http://YOUR_SITE.com/ANY/LISTENING/URL/YOU/WANT' 'normal_return_url=http://YOUR_SITE.com/NORMAL/FALLBACK/URL' 'cancel_return_url=http://YOUR_SITE.com/CANCEL/URL' 'merchant_country=fr' 'language=fr' 'currency_code=978' 'pathfile=/lib/atos/param/pathfile'"
  end
end
