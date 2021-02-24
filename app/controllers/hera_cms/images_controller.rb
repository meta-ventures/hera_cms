require_dependency "hera_cms/application_controller"

module HeraCms
  class ImagesController < ApplicationController

    def update
      @image = HeraCms::Image.find(params[:id])

      if @image.update(image_params)
        render json: { redirect: URI(request.referer).path }, status: 200
      else
        render json: { errors: @image.errors.full_messages }, status: 422
      end
    end

    private

    def image_params
      params.require(:image).permit(:identifier, :upload, :url, :classes, :style)
    end
  end
end
