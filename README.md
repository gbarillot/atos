Atos, a Ruby on Rails gateway for SIPS/ATOS french online payments API
===

Usage
---
1. Drop the files given by your bank in your /lib dir, so it should look like this :

```
    /lib
      /atos
       /bin
         request
         request_2.4.18_2.96
         ....

     /param
       certif.fr.014295303911111
       parmcom.014295303911111
       parmcom.*
       pathfile
```

2. From your controller, call the API like this :
```
    @request = Atos.new.request(
      :merchant_id            => '014295303911111',
      :amount                 => '1500',
      :customer_id            => 'YOUR_CUSTOMER_ID',
      :automatic_response_url => 'http://YOUR_SITE.com/ANY/LISTENING/URL/YOU/WANT',
      :normal_return_url      => 'http://YOUR_SITE.com/NORMAL/RETURN/URL',
      :cancel_return_url      => 'http://YOUR_SITE.com/CANCEL/URL'
    )
```
3. And then show the @request in your view (it's an HTML form)

----- Let the customer pay on the bank platform, then listen to its response ----

4. Now, you can catch the DATA parameter in response by listening to the 'automatic\_response\_url' you gave above
```
  response = Atos.new.response(params[:DATA])
```

5. Finally, you get a hash in 'response', that follows the API specs :
```
    {
      :code
      :error
      :merchant_id
      :merchant_country
      :amount
      :transaction_id
      :payment_means
      :transmission_date
      :payment_time
      :payment_date
      :response_code
      :payment_certificate
      :authorisation_id
      :currency_code
      :card_number
      :cvv_flag
      :cvv_response_code
      :bank_response_code
      :complementary_code
      :complementary_info
      :return_context
      :caddie
      :receipt_complement
      :merchant_language
      :language
      :customer_id
      :order_id
      :customer_email
      :customer_ip_address
      :capture_day
      :capture_mode
      :data
    }
```

Notes
---
- merchant_id, amount, customer_id, automatic_response_url, normal_return_url and cancel_return_url
  are required to push a request, but you can freely add others (shopping cart, customer email...),
  according to the API docs.

- Default language is set to 'fr' and currency to 'Euro', simply pass your own 'locale/currency' in
  the request to override.

- I prefer conventions over configuration, but you can also override with your own path dirs while
  instanciating the Atos class. You just add one step to the shortand way :

```
    @request = Atos.new(
      :root_path     => '/where',
      :request_path  => '/where/ever',
      :response_path => '/where/ever/you',
      :pathfile_path => '/where/ever/you/want'
    )
```

...And then...

```
    @request.request(
      :merchant_id       => '014295303911111',
      :amount            => '1500',
      :customer_id       => YOUR_CUSTOMER_ID,:automatic_response_url=>'http://YOUR_SITE.com/ANY/LISTENING/URL/YOU/WANT',
      :normal_return_url => 'http://YOUR_SITE.com/NORMAL/FALLBACK/URL',
      :cancel_return_url => 'http://YOUR_SITE.com/CANCEL/URL'
    )
```

* Don't forget to check at the 'pathfile' Atos file, and fill requested paths according to your app absolute location on the server

* Drop the credit card logos in a public dir, then fill this directory's absolute location on the server
  in the '/lib/atos/param/pathfile' file

* The '014295303911111' merchant\_id I use all the way here is the test merchant\_id, obviously, use you own.

