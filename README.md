### Last user storie I was working on:

- **Story**: As the consumer, I want to see a status code of 422 when a post request can not be completed because of validation errors.

## The API Stories

The Forest Service is considering a proposal to place in conservancy a forest of virgin Douglas fir just outside of Portland, Oregon. Before they give the go-ahead, they need to do an environmental impact study. They've asked you to build an API the rangers can use to report wildlife sightings.

- **Story**: As a developer I can create an animal model in the database. An animal has the following information: common name, latin name, kingdom (mammal, insect, etc.).

to create an animal resource:

```
  rails g resource Animal common_name latin_name animal_class
  rails db:migrate
```

created some seeds:

```ruby
animals =
[
  {
    common_name: "Arctic Fox",
    latin_name: "Alopex Vulpini",
    animal_class: "mammal"
  },
  {
    common_name: "Ladybird Beetle",
    latin_name: "Coccinella magnifica",
    animal_class: "insect"
  },
  {
    common_name: "Banana Slug",
    latin_name: "Ariolimax californicus",
    animal_class: "gastropod"
  },
]

animals.each do |animal|
  Animal.create animal
end
```

- **Story**: As the consumer of the API I can see all the animals in the database.

two methods in the controller:

```ruby

def index
    animals = Animal.all
    render json: animals
  end

  def show
    animal = Animal.find(params[:id])
    render json: animal
  end


```

- **Story**: As the consumer of the API I can update an animal in the database.

in animals_controller.rb:

```ruby
def update
    #this is for the PUT/PATCH 'animals/"id' route
    animal = Animal.find(params[:id])
    if animal.update(animal_params)
      render json: animal
    else
      render json: animal.errors.full_message
    end
  end

```

in order for rails to accept it we need to tell it not to check for an authenticity token. in the application_controller:

```ruby
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
end

```

- **Story**: As the consumer of the API I can destroy an animal in the database.

```ruby
  def destroy
    #this is for the DELETE '/animals/:id' route
    animal = Animal.find(params[:id])
    animal.destroy
    #return nothing
    head :no_content
  end

```

- **Story**: As the consumer of the API I can create a new animal in the database.

in controller:

```ruby
def create
  animal = Animal.new(animal_params)
  if animal.save
    render json: animal
  else
    render animal.errors.full_messages
  end
end
```

- **Story**: As the consumer of the API I can create a sighting of an animal with date (use the _datetime_ datatype), a latitude, and a longitude.
  - _Hint_: An animal has_many sightings. (rails g resource Sighting animal_id:integer ...)

to created a sighting resource:

```
rails g resource Sighting animal_id:integer latitude:decimal longitude:decimal
```

google maps says we should make the floats a certain precision and scale. I don't think we'll need that for this but for practice I added them to the migration:

```ruby
class CreateSightings < ActiveRecord::Migration[6.1]
  def change
    create_table :sightings do |t|
      t.integer :animal_id
      t.decimal :latitude, :precision=>10, :scale=>6
      t.decimal :longitude, :precision=>10, :scale=>6

      t.timestamps
    end
  end
end

```

also added relationships to the models:

```ruby
class Animal < ApplicationRecord
  has_many :sightings
end
```

```ruby
class Sighting < ApplicationRecord
  belong_to :animal
end
```

my controller so far:

```ruby
class SightingsController < ApplicationController
  #so that I can see all the created sightings
  def index
    sightings = Sighting.all
    render json: sightings
  end


  #I feel like there's a better way to do this but I'll need to look a bit more.
  def create
    sighting = Sighting.new(sighting_params)
    if sighting.save
      render json: sighting
    else
      render json: sighting.errors.full_messages
    end
  end


  private
  def sighting_params
    params.require(:sighting).permit(:latitude,:longitude,:animal_id)
  end
end


```

- **Story**: As the consumer of the API I can update an animal sighting in the database.

added two new actions:

```ruby
  def update
    sighting = Sighting.find(params[:id])
    if sighting.update(sighting_params)
      render json: sighting
    else
      render json: sighting.errors.full_messages
    end
  end

  def destroy
    sighting = Sighting.find(params[:id])
    sighting.destroy
    head :no_content
  end

```

- **Story**: As the consumer of the API I can destroy an animal sighting in the database.
- **Story**: As the consumer of the API, when I view a specific animal, I can also see a list sightings of that animal.
  - _Hint_: Checkout the [ Ruby on Rails API docs ](https://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html#method-i-as_json) on how to include associations.

updated the animal controller's show method to:

```ruby
def show
  animal = Animal.find(params[:id])
  render json: animal.as_json(include: :sightings)
end
```

- **Story**: As the consumer of the API, I can run a report to list all sightings during a given time period.
  - _Hint_: Your controller can look like this:

```ruby
class SightingsController < ApplicationController
  def index
    sightings = Sighting.where(date: params[:start_date]..params[:end_date])
    render json: sightings
  end
end
```

ended up doing this:

```ruby
def index
  start_date = params[:start_date].to_date || Date.today.at_beginning_of_month
  end_date   = params[:end_date].to_date ||  Date.today.at_beginning_of_month.next_month

  sightings = Sighting.where(date: start_date..end_date)
  render json: sightings
end
```

with the default date range limited to our current month if no params are passed. needed to convert the params to dates in case some the date was incomplete. unsure how to add these to strong parameters.

Remember to add the start_date and end_date to what is permitted in your strong parameters method.

## Stretch Challenges

**Note**: All of these stories should include the proper RSpec tests. Validations will require specs in `spec/models`, and the controller method will require specs in `spec/requests`.

- **Story**: As the consumer of the API, I want to see validation errors if a sighting doesn't include: latitude, longitude, or a date.
- **Story**: As the consumer of the API, I want to see validation errors if an animal doesn't include a common name, or a latin name.
- **Story**: As the consumer of the API, I want to see a validation error if the animals latin name matches exactly the common name.
- **Story**: As the consumer of the API, I want to see a validation error if the animals latin name or common name are not unique.
- **Story**: As the consumer, I want to see a status code of 422 when a post request can not be completed because of validation errors.
  - Check out [Handling Errors in an API Application the Rails Way](https://blog.rebased.pl/2016/11/07/api-error-handling.html)

## Super Stretch Challenge

- **Story**: As the consumer of the API, I can submit sighting data along with a new animal in a single API call.
  - _Hint_: Look into `accepts_nested_attributes_for`
