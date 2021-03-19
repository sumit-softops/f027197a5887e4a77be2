# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version : 2.6.5

* System dependencies : Install Elastic Search

* Gems to install : Used "searchkick" for seaching user, Used "kaminari" for pagination

* rails db:create, rails db:migrate, rails db:seed

* rails s

After this you can run API's :

Implemented API endpoints are: 

-  User Index API :
		GET "/api/users"

-  User Show API :
		GET "/api/user/:id"

-  User Create API :
		POST "/api/user"

-  User Update API :
		PUT "/api/user/:id"

-  User Destroy API :
		DELETE "/api/user/:id"

-  User Typeahead API :
		GET " /api/typeahead/:input"

Here is PostMan Collection :

https://www.getpostman.com/collections/6fd6796aed3a69a2a891