class Api::V1::EnquiriesController < Api::BaseController

  def create
    @enquiry = Enquiry.new(enquiry_params)
    @enquiry.user = current_user
    if @enquiry.save
      render json: { status: true, message: 'Your query was sent to admin.' }
    else
      render json: { status: false, errors: @enquiry.errors }
    end
  end

  private

  def enquiry_params
    params.require(:enquiry).permit(:subject, :enquiry)
  end

end