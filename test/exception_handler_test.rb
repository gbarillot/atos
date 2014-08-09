require 'test_helper'

describe ExceptionHandler do #< ActiveSupport::TestCase

  it "raises an exception when missing parameter merchant_id" do
    err = ->{ 
      ExceptionHandler.validate_request_params({
        :merchant_i            => '',
        :customer_id            => 'YOUR_CUSTOMER_ID',
        :amount                 => '1500',
        :automatic_response_url => 'http://YOUR_SITE.com/ANY/LISTENING/URL/YOU/WANT',
        :normal_return_url      => 'http://YOUR_SITE.com/NORMAL/RETURN/URL',
        :cancel_return_url      => 'http://YOUR_SITE.com/CANCEL/URL'
      })
    }.must_raise RuntimeError
  end

  it "raises an exception when missing parameter customer_id" do
    err = ->{ 
      ExceptionHandler.validate_request_params({
        :merchant_id             => '',
        :customer_i            => 'YOUR_CUSTOMER_ID',
        :amount                 => '1500',
        :automatic_response_url => 'http://YOUR_SITE.com/ANY/LISTENING/URL/YOU/WANT',
        :normal_return_url      => 'http://YOUR_SITE.com/NORMAL/RETURN/URL',
        :cancel_return_url      => 'http://YOUR_SITE.com/CANCEL/URL'
      })
    }.must_raise RuntimeError
  end

  it "raise and exception when missing parameter amount" do
    err = ->{
      ExceptionHandler.validate_request_params({
        :merchant_id             => '',
        :customer_id            => 'YOUR_CUSTOMER_ID',
        :amoun                 => '1500',
        :automatic_response_url => 'http://YOUR_SITE.com/ANY/LISTENING/URL/YOU/WANT',
        :normal_return_url      => 'http://YOUR_SITE.com/NORMAL/RETURN/URL',
        :cancel_return_url      => 'http://YOUR_SITE.com/CANCEL/URL'
      })
    }.must_raise RuntimeError
  end

  it "raise and exception when missing parameter automatic_response_url" do
    err = ->{
      ExceptionHandler.validate_request_params({
        :merchant_id             => '',
        :customer_id            => 'YOUR_CUSTOMER_ID',
        :amount                 => '1500',
        :automatic_response_ur => 'http://YOUR_SITE.com/ANY/LISTENING/URL/YOU/WANT',
        :normal_return_url      => 'http://YOUR_SITE.com/NORMAL/RETURN/URL',
        :cancel_return_url      => 'http://YOUR_SITE.com/CANCEL/URL'
      })
    }.must_raise RuntimeError
  end

  it "raise and exception when missing parameter normal_return_url" do
    err = ->{
      ExceptionHandler.validate_request_params({
        :merchat_id             => '',
        :customer_id            => 'YOUR_CUSTOMER_ID',
        :amount                 => '1500',
        :automatic_response_url => 'http://YOUR_SITE.com/ANY/LISTENING/URL/YOU/WANT',
        :normal_return_ur      => 'http://YOUR_SITE.com/NORMAL/RETURN/URL',
        :cancel_return_url      => 'http://YOUR_SITE.com/CANCEL/URL'
      })
    }.must_raise RuntimeError
  end

  it "raise and exception when missing parameter cancel_return_url" do
    err = ->{
      ExceptionHandler.validate_request_params({
        :merchat_id             => '',
        :customer_id            => 'YOUR_CUSTOMER_ID',
        :amount                 => '1500',
        :automatic_response_url => 'http://YOUR_SITE.com/ANY/LISTENING/URL/YOU/WANT',
        :normal_return_url      => 'http://YOUR_SITE.com/NORMAL/RETURN/URL',
        :cancel_return_ur      => 'http://YOUR_SITE.com/CANCEL/URL'
      })
    }.must_raise RuntimeError
  end

end
