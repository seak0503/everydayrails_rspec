class PhonesController < ApplicationController
  def show
    @phone = Phone.find(params[:id])
    @contact = Contact.find(params[:contact_id])
    render action: "show"
  end
end
