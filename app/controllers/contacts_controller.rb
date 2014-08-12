class ContactsController < ApplicationController
	before_action :initialize_search, only: [:show, :index, :edit]

	def index
		@contacts = @search.result(distinct: true).includes(:addresses).order(:name)

		respond_to do |format|
			format.html # index.html.erb
  		format.json { render json: @contacts }
		end
	end

	def show
		@search = Contact.search(params[:q])
		@contacts = @search.result(distinct: true).order(:name)
		@contact = Contact.includes(:addresses, :contact_information).find(params[:id])
	end

	def new
		@search = Contact.search(params[:q])
		@contacts = @search.result(distinct: true).order(:name)
		@contact = Contact.new
		@contact.addresses.build
		@contact.emails.build
	end


	def create
		@contact = Contact.new(contact_params)

		if @contact.save
			redirect_to @contact
		else
			render 'new'
		end
	end


	def edit
		@contact = Contact.find(params[:id])
	end


	def update
		@contact = Contact.find(params[:id])
		if @contact.update_attributes(contact_params)
			redirect_to contact_path(@contact), notice: "Kontakt aktualisiert."
		else
			render 'edit'
		end
	end

	def destroy
		@contact = Contact.find(params[:id])
		@contact.destroy

		redirect_to contacts_path, :flash => { :success => "Contact deleted!" }
	end


	private
	def contact_params
		params.require(:contact).permit(
			:name,
			addresses_attributes: [
				:id,
				:contact_id,
				:description,
				:name,
				:street,
				:house_number,
				:zip,
				:city,
				:country,
				:_destroy	
			],
			emails_attributes: [
				:id,
				:contact_id,
				:name,
				:value,
				:_destroy
			],
			phones_attributes: [
				:id,
				:contact_id,
				:name,
				:value,
				:_destroy
			]
		)
	end

	def initialize_search
		@search = Contact.search(params[:q])
		@contacts = @search.result(distinct: true)
	end



end