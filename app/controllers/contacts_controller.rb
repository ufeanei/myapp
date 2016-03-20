class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contacts_params)
    if @contact.save
      flash[:success] = "Thank you! Your message has been sent"
      redirect_to root_path
    else
      flash[:error] = 'Message not sent due to errors'
      render :new
    end
  end


  private

  def contacts_params
    params.require(:contact).permit(:name, :email, :comments)
  end

end