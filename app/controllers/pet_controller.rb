class PetController < AppController

    set :views, './app/views'

    # @method: Add a new pet to the DB
    post '/todos/create' do
        begin
            pet = Pet.create( self.data(create: true) )
            json_response(code: 201, data: todo)
        rescue => e
            json_response(code: 422, data: { error: e.message })
        end
    end

    # @method: Display all pets
    get '/pet' do
        pet = Pet.all
        json_response(data: pets)
    end

    # @view: Renders an erb file which shows all pets
    # erb has content_type because we want to override the default set above
    get '/' do
        @pets = Pet.all.map { |pet|
          {
            pet: pet,
            badge: pet_status_badge(pet.status)
          }
        }
        @i = 1
        erb_response :pets
    end

    # @method: Update existing pets according to :id
    put '/pets/update/:id' do
        begin
            pet = Pet.find(self.pet_id)
            pet.update(self.data)
            json_response(data: { message: "pet updated successfully" })
        rescue => e
            json_response(code: 422 ,data: { error: e.message })
        end
    end

    # @method: Delete pet based on :id
    delete '/pets/destroy/:id' do
        begin
            pet = Pet.find(self.pet_id)
            pet.destroy
            json_response(data: { message: "pet deleted successfully" })
        rescue => e
          json_response(code: 422, data: { error: e.message })
        end
    end


    private

    # @helper: format body data
    def data(create: false)
        payload = JSON.parse(request.body.read)
        puts "the payload is : #{payload}"
        payload
    rescue JSON::ParserError => e 
        puts "Failed to parse JSON data: #{e}"
        nil
    end

    # @helper: retrieve pet :id
    def pet_id
        params['id'].to_i
    end
end