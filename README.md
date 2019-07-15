# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


session - to save user info at the server side. Its nothing but a key value pair
cookies - to save the user data at the client side.

filters - They are available only inside controllers
  before_action # run before every action
  after_action # runs after every action
  around_action # runs before and after every action

flash messages - this also a key and value pair to store the flash message

Validation  -
Two types of validation
  Client side with JS
  Server side validation can be made inside models
Bootstrap
Callbacks hooks in the object life cycle
  basically they provides you the feasibility to change the columns values before, after and around the object state
  Only three object state are available
    Create
    Update
    Delete
partial : can be shared across all the templates in a specific view
  start with "_name"


For Sunday

Association
Rest Api
Db query


irb(main):010:0> User.where(email: 'test@gmail.com').count
   (0.4ms)  SELECT COUNT(*) FROM "users" WHERE "users"."email" = ?  [["email", "test@gmail.com"]]
=> 1
irb(main):011:0> User.where(email: 'test@gmail.com').count
   (0.5ms)  SELECT COUNT(*) FROM "users" WHERE "users"."email" = ?  [["email", "test@gmail.com"]]
=> 2
irb(main):012:0>



--------------------------------------------------------------------------------------------------------------

irb(main):006:0> user = User.where(email: "test@gmail.com").last
  User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."email" = ? ORDER BY "users"."id" DESC LIMIT ?  [["email", "test@gmail.com"], ["LIMIT", 1]]
=> #<User id: 1, name: "test-update", email: "test@gmail.com", password: "test123", confirm_password: "test123", created_at: "2019-06-27 01:30:41", updated_at: "2019-06-27 01:53:49">
irb(main):007:0> user.password
=> "test123"
irb(main):008:0> user.password = Digest::MD5.hexdigest(user.password)
=> "cc03e747a6afbbcbf8be7668acfebee5"
irb(main):009:0> user.confirm_password = Digest::MD5.hexdigest(user.confirm_password)
=> "cc03e747a6afbbcbf8be7668acfebee5"
irb(main):010:0> user.save
   (0.2ms)  begin transaction
  User Exists (0.3ms)  SELECT  1 AS one FROM "users" WHERE "users"."email" = ? AND "users"."id" != ? LIMIT ?  [["email", "test@gmail.com"], ["id", 1], ["LIMIT", 1]]
   (0.1ms)  rollback transaction
=> false
irb(main):011:0> user.errors
=> #<ActiveModel::Errors:0x00007f971b1ae7a8 @base=#<User id: 1, name: "test-update", email: "test@gmail.com", password: "cc03e747a6afbbcbf8be7668acfebee5", confirm_password: "cc03e747a6afbbcbf8be7668acfebee5", created_at: "2019-06-27 01:30:41", updated_at: "2019-06-27 01:53:49">, @messages={:name=>["is too long (maximum is 10 characters)"]}, @details={:name=>[{:error=>:too_long, :count=>10}]}>
irb(main):012:0> user       
=> #<User id: 1, name: "test-update", email: "test@gmail.com", password: "cc03e747a6afbbcbf8be7668acfebee5", confirm_password: "cc03e747a6afbbcbf8be7668acfebee5", created_at: "2019-06-27 01:30:41", updated_at: "2019-06-27 01:53:49">
irb(main):013:0> user.save(validate: false)
   (0.1ms)  begin transaction
  User Update (0.6ms)  UPDATE "users" SET "password" = ?, "confirm_password" = ?, "updated_at" = ? WHERE "users"."id" = ?  [["password", "cc03e747a6afbbcbf8be7668acfebee5"], ["confirm_password", "cc03e747a6afbbcbf8be7668acfebee5"], ["updated_at", "2019-06-29 03:36:02.944976"], ["id", 1]]
   (3.0ms)  commit transaction
=> true
irb(main):014:0>



Association:
  Helps you to join one or more table.

  belongs_to 1:1
  has_one 1:1
  has_many  1:M
  has_one :through 1:1
  has_many :through  1:M
  has_and_belongs_to_many  M:M
  polymorphic association
  STI (Single table inheritance)
  Self  join


  How to add new column to existing table
  rails g migration add_column_to_article user:belongs_to

  OR
  rails g migration add_column_to_article user_id:integer



  #Db query


How to find a single record
TableName.find :id # this raise exception

TableName.find_by_id :id # this does not raise exception
irb(main):006:0> User.find 1
  User Load (0.4ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
=> #<User id: 1, name: "test-update", email: "test@gmail.com", password: "cc03e747a6afbbcbf8be7668acfebee5", confirm_password: "cc03e747a6afbbcbf8be7668acfebee5", created_at: "2019-06-27 01:30:41", updated_at: "2019-06-29 03:36:02">
irb(main):007:0> User.find 100
  User Load (0.2ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 100], ["LIMIT", 1]]
ActiveRecord::RecordNotFound: Couldn't find User with 'id'=100
	from (irb):7
irb(main):008:0> User.find_by_id 100
  User Load (0.2ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 100], ["LIMIT", 1]]
=> nil
irb(main):009:0> User.find_by_id 1  
  User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
=> #<User id: 1, name: "test-update", email: "test@gmail.com", password: "cc03e747a6afbbcbf8be7668acfebee5", confirm_password: "cc03e747a6afbbcbf8be7668acfebee5", created_at: "2019-06-27 01:30:41", updated_at: "2019-06-29 03:36:02">
irb(main):010:0>

Find with where clause .

where return a collection(ActiveRecord::Relation)

irb(main):012:0* User.where(name: "test", email: "test@gmail.com")
  User Load (0.5ms)  SELECT  "users".* FROM "users" WHERE "users"."name" = ? AND "users"."email" = ? LIMIT ?  [["name", "test"], ["email", "test@gmail.com"], ["LIMIT", 11]]
=> #<ActiveRecord::Relation []>
irb(main):013:0>


irb(main):014:0> User.pluck(:id)                                         
   (0.8ms)  SELECT "users"."id" FROM "users"
=> [1, 3, 4, 7]
irb(main):015:0> User.pluck(:id, :email)
   (0.4ms)  SELECT "users"."id", "users"."email" FROM "users"
=> [[1, "test@gmail.com"], [3, "page@gmail.com"], [4, "sriram@gmail.com"], [7, "enc@gmail.com"]]
irb(main):016:0> User.pluck(:id, :email, :name)
   (0.4ms)  SELECT "users"."id", "users"."email", "users"."name" FROM "users"
=> [[1, "test@gmail.com", "test-update"], [3, "page@gmail.com", "page"], [4, "sriram@gmail.com", "Sriram"], [7, "enc@gmail.com", "test enc"]]
irb(main):017:0>


irb(main):019:0* User.ids                      
   (0.2ms)  SELECT "users"."id" FROM "users"
=> [1, 3, 4, 7]
irb(main):020:0>

irb(main):024:0> Article.find_or_create_by(title: 'test', content: 'check test account', user: (User.find 1))
  User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  Article Load (0.4ms)  SELECT  "articles".* FROM "articles" WHERE "articles"."title" = ? AND "articles"."content" = ? AND "articles"."user_id" = ? LIMIT ?  [["title", "test"], ["content", "check test account"], ["user_id", 1], ["LIMIT", 1]]
   (0.1ms)  begin transaction
  Article Create (1.1ms)  INSERT INTO "articles" ("title", "content", "created_at", "updated_at", "user_id") VALUES (?, ?, ?, ?, ?)  [["title", "test"], ["content", "check test account"], ["created_at", "2019-07-01 01:46:41.090272"], ["updated_at", "2019-07-01 01:46:41.090272"], ["user_id", 1]]
   (2.9ms)  commit transaction


   irb(main):049:0> Article.order(id: 'ASC')
     Article Load (0.3ms)  SELECT  "articles".* FROM "articles" ORDER BY "articles"."id" ASC LIMIT ?  [["LIMIT", 11]]
   => #<ActiveRecord::Relation [#<Article id: 1, title: "India lost yesterday", content: "Ind Vs Eng", created_at: "2019-07-01 01:20:47", updated_at: "2019-07-01 01:20:47", user_id: 1>, #<Article id: 2, title: "Hoping to rain", content: "Its bad situation without wTER", created_at: "2019-07-01 01:22:06", updated_at: "2019-07-01 01:22:06", user_id: 1>, #<Article id: 3, title: "test", content: "check test account", created_at: "2019-07-01 01:46:41", updated_at: "2019-07-01 01:46:41", user_id: 1>]>
   irb(main):050:0> Article.order(id: 'DESC')
     Article Load (0.4ms)  SELECT  "articles".* FROM "articles" ORDER BY "articles"."id" DESC LIMIT ?  [["LIMIT", 11]]
   => #<ActiveRecord::Relation [#<Article id: 3, title: "test", content: "check test account", created_at: "2019-07-01 01:46:41", updated_at: "2019-07-01 01:46:41", user_id: 1>, #<Article id: 2, title: "Hoping to rain", content: "Its bad situation without wTER", created_at: "2019-07-01 01:22:06", updated_at: "2019-07-01 01:22:06", user_id: 1>, #<Article id: 1, title: "India lost yesterday", content: "Ind Vs Eng", created_at: "2019-07-01 01:20:47", updated_at: "2019-07-01 01:20:47", user_id: 1>]>
   irb(main):051:0> Article.order(created_at: 'DESC')
     Article Load (0.9ms)  SELECT  "articles".* FROM "articles" ORDER BY "articles"."created_at" DESC LIMIT ?  [["LIMIT", 11]]
   => #<ActiveRecord::Relation [#<Article id: 3, title: "test", content: "check test account", created_at: "2019-07-01 01:46:41", updated_at: "2019-07-01 01:46:41", user_id: 1>, #<Article id: 2, title: "Hoping to rain", content: "Its bad situation without wTER", created_at: "2019-07-01 01:22:06", updated_at: "2019-07-01 01:22:06", user_id: 1>, #<Article id: 1, title: "India lost yesterday", content: "Ind Vs Eng", created_at: "2019-07-01 01:20:47", updated_at: "2019-07-01 01:20:47", user_id: 1>]>
   irb(main):052:0>

   https://guides.rubyonrails.org/active_record_querying.html

   Srirams-MacBook-Air:sample Sriram_Rickey$ rails g mailer send_email welcome



  $('meta[name="csrf-token"]')


Srirams-MacBook-Air:sample Sriram_Rickey$ rails g controller api/users --no-helper --no-assets --no-template-engine --no-test
Running via Spring preloader in process 60365
      create  app/controllers/api/users_controller.rb
      invoke  test_unit
      create    test/controllers/api/users_controller_test.rb
Srirams-MacBook-Air:sample Sriram_Rickey$



SYNTAX OF CURL:
  curl -X method -d data endpoint

  Example :
    curl -X GET http://localhost:3000/api/users.json
    OR
    curl -X GET -H "accept: application/json" http://localhost:3000/api/users


    Srirams-MacBook-Air:sample Sriram_Rickey$ curl -X POST -d "user[name]=terminal&user[email]=terminal@gmail.com&user[password]=terminal&user[confirm_password]=terminal" -H "accept: application/json" http://localhost:3000/api/users
    {"id":15,"name":"terminal","email":"terminal@gmail.com","password":"ede997b0caf2ec398110d79d9eba38bb","confirm_password":"ede997b0caf2ec398110d79d9eba38bb","created_at":"2019-07-02T01:40:19.344Z","updated_at":"2019-07-02T01:40:19.344Z"}Srirams-MacBook-Air:sample Sriram_Rickey$


    Srirams-MacBook-Air:sample Sriram_Rickey$ curl -X PATCH -d "user[name]=term" -H "accept: application/json" http://localhost:3000/api/users/15
    {"id":15,"name":"term","email":"terminal@gmail.com","password":"670c295666d55447e03944f6b8847443","confirm_password":"670c295666d55447e03944f6b8847443","created_at":"2019-07-02T01:40:19.344Z","updated_at":"2019-07-02T01:45:27.419Z"}Srirams-MacBook-Air:sample Sriram_Rickey$


curl -X DELETE http://localhost:3000/api/users/15 -H "accept: application/json"


curl -X GET http://localhost:3000/api/users/16 -H "accept: application/json"

OR

curl -X GET http://localhost:3000/api/users/16 -H "accept: application/xml"  






Hint:
controller  - template1 (To on board a new record or to edit an existing record) : form_for

@object = TableName.new   form_for @object

            - template2 (to verify a record )  form_tag









Strong parameter :
irb(main):001:0> h = Hash.new
=> {}
irb(main):002:0> h[:name] = "symbol"
=> "symbol"
irb(main):003:0> h
=> {:name=>"symbol"}
irb(main):004:0> h["name"] = "string"
=> "string"
irb(main):005:0> h
=> {:name=>"symbol", "name"=>"string"}


irb(main):001:0> r = HashWithIndifferentAccess.new
=> {}
irb(main):002:0> r
=> {}
irb(main):003:0> r[:name] = "String"
=> "String"
irb(main):004:0> r
=> {"name"=>"String"}
irb(main):005:0> r["name"] = "Hello"
=> "Hello"
irb(main):006:0> r
=> {"name"=>"Hello"}
irb(main):007:0>   





Photo Management in rails with paperclip

add gem (paperclip)to Gemfile
create a table without any culumns and ask paperclip to use it
put the validation part of paperclip in table class

Paperclip needs imagemagick package to create variosu size of original image
brew install imagemagick

new.html=>
<%= f.fields_for :image do | image |%>
  <tr>
    <td><%= image.label :photo%></td>
    <td><%= image.file_field :photo%></td>
  </tr>
<%end%>

  user.rb => accepts_nested_attributes_for :image

//index.html
  <td>
    <% unless user.image.nil?%>
    <%= image_tag user.image.photo(:thumb) %>
    <%end%>
  </td>



For user authentication : read devise gem
For user authorization : read cancan gem



Left association part :
    has_and_belongs_to_many
    polymorphic
    Single table Inheritance



    class Assembly
      has_and_belongs_to_many :parts
    end

    class Part
      has_and_belongs_to_many :assemblies
    end

   class AssemblyParts
    belongs_to :assembly
    belongs_to :part
   end
-------------------------------

polymorphic association


class User
  has_one :image, as: :entity
end

class Subscriber
  has_one :image, as: :entity
end

class Article
  has_many :images, as: :entity
end


class Publisher
  has_one :image, as: :entity
end


class Image
  <!-- belongs_to :user
  belongs_to :article
  belongs_to :subscriber -->
  belongs_to :entity, polymorphic: true
end



Image Table
<!-- user_id: integer
subscriber_id
article_id -->
entity_id
entity_type



# get image

@user = User.first
@user.image
ORM : select * from users limit 1 order Asc
select * from images where user_id = @user.id


@subscriber = Subscriber.first
@subscriber.image
ORM : select * from subscribers limit 1 order Asc
select * from images where subscriber_id = @subscriber.id



Step to make polymorphic true
Step: 1
From the image model add below lines
belongs_to :entity, polymorphic: true

and then add two columns inside image table named as entity_type and entity_id

Step 2:
go to the models which are using this table and just after has_one or has_many just write as below
has_one :image, as: :entity
has_many :image, as: :entity

@user = User.first(select * from users limit 1 order by Asc)
@user.image (select * from images where entity_id = @user.id and entity_type = "User")

@article = Article.first(select * from articles limit 1 order by Asc)
@article.image (select * from images where entity_id = @article.id and entity_type = "Article")


STI
See your sport model


User.find_by_sql("select * from users")


Write here from inset query
ActiveRecord::Base.connection.execute("insert into articles(title, content, user_id, created_at, updated_at) values('from sql', 'sql', '1', '2019-07-04 01:16)")


irb(main):039:0> ActiveRecord::Base.connection.select_one("select * from users")
   (0.5ms)  select * from users
=> {"id"=>1, "name"=>"test-update", "email"=>"test@gmail.com", "password"=>"cc03e747a6afbbcbf8be7668acfebee5", "confirm_password"=>"cc03e747a6afbbcbf8be7668acfebee5", "created_at"=>"2019-06-27 01:30:41.562614", "updated_at"=>"2019-06-29 03:36:02.944976"}
irb(main):040:0> ActiveRecord::Base.connection.select_all("select * from users")
   (0.4ms)  select * from users
=> #<ActiveRecord::Result:0x00007ff68cbe7b40 @columns=["id", "name", "email", "password", "confirm_password", "created_at", "updated_at"], @rows=[[1, "test-update", "test@gmail.com", "cc03e747a6afbbcbf8be7668acfebee5", "cc03e747a6afbbcbf8be7668acfebee5", "2019-06-27 01:30:41.562614", "2019-06-29 03:36:02.944976"], [3, "page", "page@gmail.com", "cfe25171761920d05922b1842abc4123", "cfe25171761920d05922b1842abc4123", "2019-06-27 01:34:09.542908", "2019-06-29 03:33:23.613485"], [7, "test enc", "enc@gmail.com", "3a37583cbdc41fae0168b7d1d84de109", "3a37583cbdc41fae0168b7d1d84de109", "2019-06-29 03:43:25.103293", "2019-06-29 03:43:25.103293"], [10, "sandy ", "sandhyareddyn1998@gmail.com", "73c18c59a39b18382081ec00bb456d43", "73c18c59a39b18382081ec00bb456d43", "2019-07-01 06:03:26.823743", "2019-07-01 06:03:26.823743"], [11, "sohan", "sohanoffice46@gmail.com", "098f6bcd4621d373cade4e832627b4f6", "098f6bcd4621d373cade4e832627b4f6", "2019-07-01 09:49:16.976045", "2019-07-01 09:49:16.976045"], [12, "Sriram", "kaluvasriram@gmail.com", "098f6bcd4621d373cade4e832627b4f6", "098f6bcd4621d373cade4e832627b4f6", "2019-07-02 00:50:29.234274", "2019-07-02 00:50:29.234274"], [13, "htoken", "htoken@gmail.com", "5d41402abc4b2a76b9719d911017c592", "5d41402abc4b2a76b9719d911017c592", "2019-07-02 01:07:56.592665", "2019-07-02 01:07:56.592665"], [14, "token", "token@gmail.com", "5d41402abc4b2a76b9719d911017c592", "5d41402abc4b2a76b9719d911017c592", "2019-07-02 01:10:52.628210", "2019-07-02 01:10:52.628210"], [16, "postman", "postman@gmail.com", "03d476861afd384510f2cb80ccfa8511", "03d476861afd384510f2cb80ccfa8511", "2019-07-02 01:41:42.527620", "2019-07-02 01:41:42.527620"], [17, "image", "image2@gmail.com", "78805a221a988e79ef3f42d7c5bfd418", "78805a221a988e79ef3f42d7c5bfd418", "2019-07-04 01:16:01.420905", "2019-07-04 01:16:01.420905"]], @hash_rows=nil, @column_types={}>
irb(main):041:0>


Performance related gems
rubocop
memory profiler
benchmark
new relic
