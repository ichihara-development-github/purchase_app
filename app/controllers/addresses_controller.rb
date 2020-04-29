class AddressesController < ApplicationController
  def create
    @store.address.create(params[:name])
    redirect_to root_path
  end

  def destroy
    Address.destroy_all
    redirect_to root_path
  end

  private

  def address_params
    params.require(:address).permit(:name)
  end
end
